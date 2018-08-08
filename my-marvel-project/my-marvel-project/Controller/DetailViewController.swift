//
//  DetailViewController.swift
//  my-marvel-project
//
//  Created by Alexandre Gabassi on 08/08/18.
//  Copyright © 2018 Alexandre Gabassi. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {

    @IBOutlet weak var imgComic: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var txtDescription: UITextView!

    var idDetailCard = "0"
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async(execute: {
            self.activityIndicator.frame = self.view.bounds
            self.view.addSubview(self.activityIndicator)
            self.activityIndicator.startAnimating()

            self.getMarvelDetailInfo()
        })
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("DetailViewController: Carrega dados do id:\(idDetailCard)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cmdBack(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
}

extension DetailViewController {
    
    func getMarvelDetailInfo() {
        print("DetailViewController: 1")

        gCharactersRequests.getCharactersDetail(idCharacter: idDetailCard, completionHandler: { (success) -> Void in
            print("DetailViewController: 2")
            if success {
                print("DetailViewController: 3")
                if gCharactersComicData.statusComicReturn == "OK" {
                    print("DetailViewController: 4")
                    gCharactersRequests.getCharactersComicItem(urlComicItem:gCharactersComicData.comicUrl!, completionHandler: { (success) -> Void in
                        print("DetailViewController: 5")
                        if success {
                            print("DetailViewController: 6")
                            DispatchQueue.main.async(execute: {
                                if charactersComicList.charactersComicListArray.count > 0 {                                    
                                    let strImageName = gCharactersComicData.thumbnail! + "/standard_fantastic.jpg"
                                    let url = URL(string: strImageName)
                                     self.imgComic.kf.setImage(with: url)
                                    self.lblTitle.text = gCharactersComicData.title!
                                    self.txtDescription.text = gCharactersComicData.description!
                                    self.activityIndicator.removeFromSuperview()
                                }
                            })
                        }
                    })
                } else {
                    print("DetailViewController: 7")

                    DispatchQueue.main.async(execute: {
                        self.activityIndicator.removeFromSuperview()
                        self.lblTitle.text = gCharactersComicData.statusComicReturn
                    })
                }
            } else {
                DispatchQueue.main.async(execute: {
                    self.activityIndicator.removeFromSuperview()
                    self.lblTitle.text = "Comic results not found!"
                })
            }
        })
    }
}

