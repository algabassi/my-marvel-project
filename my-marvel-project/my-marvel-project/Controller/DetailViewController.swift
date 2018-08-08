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

    var idDetailCard = "0"
    @IBOutlet weak var imgComic: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var txtDescription: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async(execute: {
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
                print("DetailViewController: Carrega dados do id:\(self.idDetailCard)")

                if gCharactersComicData.statusComicReturn == "OK" {
                    gCharactersRequests.getCharactersComicItem(urlComicItem:gCharactersComicData.comicUrl!, completionHandler: { (success) -> Void in
                        if success {
                            DispatchQueue.main.async(execute: {
                                if charactersComicList.charactersComicListArray.count > 0 {
                                    self.imgComic.image = UIImage(named: gCharactersComicData.thumbnail!)
                                    self.lblTitle.text = gCharactersComicData.title!
                                    self.txtDescription.text = gCharactersComicData.description!
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

