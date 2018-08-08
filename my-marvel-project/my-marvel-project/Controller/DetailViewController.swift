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
        
        gCharactersRequests.getCharactersDetail(idCharacter: idDetailCard, completionHandler: { (success) -> Void in
            if success {
                if gCharactersComicData.statusComicReturn == "OK" {
                    gCharactersRequests.getCharactersComicItem(urlComicItem:gCharactersComicData.comicUrl!, completionHandler: { (success) -> Void in
                        if success {
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
                    DispatchQueue.main.async(execute: {
                        self.lblTitle.text = gCharactersComicData.statusComicReturn
                    })
                }
            }
        })
    }
}

