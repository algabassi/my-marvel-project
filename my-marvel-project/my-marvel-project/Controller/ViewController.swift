//
//  ViewController.swift
//  my-marvel-project
//
//  Created by Alexandre Gabassi on 06/08/18.
//  Copyright © 2018 Alexandre Gabassi. All rights reserved.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {

    @IBOutlet weak var charactersTableView: UITableView!
    @IBOutlet weak var lblTitleMessage: UILabel!
    @IBOutlet var titleImageView: UIImageView!
    
    var idSelectedChannel : String = ""
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async(execute: {            
            self.lblTitleMessage.text = "Carregando a lista \ndos melhores Personagens do mundo!"
            self.charactersTableView.isHidden = true
            self.activityIndicator.frame = self.view.bounds
            self.view.addSubview(self.activityIndicator)
            self.activityIndicator.startAnimating()
            self.getMarvelCharList()
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController {
    
    func getMarvelCharList() {
        gCharactersRequests.getCharactersList( completionHandler: { (success) -> Void in
            if success {
                DispatchQueue.main.async(execute: {
                    if success {
                        DispatchQueue.main.async(execute: {
                            self.charactersTableView.reloadData()
                            self.lblTitleMessage.text = "Selecione um Personagem\n para ver os detalhes!"
                            self.charactersTableView.isHidden = false
                            self.activityIndicator.removeFromSuperview()
                        })
                    }
                })
            }
        })
    }

}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if (segue.identifier == "detailView") {
            if let vc: DetailViewController = segue.destination as? DetailViewController {
                vc.idDetailCard = idSelectedChannel
            }
        }
    }

    
    internal func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 126.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: false)
        idSelectedChannel = "\(charactersList.charactersListArray[indexPath.row].ID ?? 0)" as String
        DispatchQueue.main.async(execute: {
            self.performSegue(withIdentifier: "detailView", sender: self)
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return charactersList.charactersListArray.count
    }
    
    private func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "CharacterTableViewCell"
        
        var cellList = tableView.dequeueReusableCell(withIdentifier: identifier) as? CharacterTableViewCell
    
        if cellList == nil {
    
            tableView.register(UINib(nibName: "CharacterTableViewCell", bundle: nil), forCellReuseIdentifier: identifier)
            cellList = (tableView.dequeueReusableCell(withIdentifier: identifier) as! CharacterTableViewCell)
        }
    
        cellList = tableView.dequeueReusableCell(withIdentifier: identifier) as? CharacterTableViewCell
    
        if charactersList.charactersListArray.count > 0 {
            cellList?.nameCharacter?.text = charactersList.charactersListArray[indexPath.row].name?.uppercased()
            
            let strImageName = charactersList.charactersListArray[indexPath.row].thumbnail! + "/landscape_small.jpg"
            let url = URL(string: strImageName)
            cellList?.imgCharacter.kf.setImage(with: url)
        }
        return cellList!
    }
}

