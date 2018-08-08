//
//  MarvelRequests.swift
//  my-marvel-project
//
//  Created by Alexandre Gabassi on 08/08/18.
//  Copyright © 2018 Alexandre Gabassi. All rights reserved.
//

import Foundation
import SwiftyJSON

class wsRequests {
    typealias CompletionHandler = (_ success:Bool) -> Void
    
    func getCharactersList( completionHandler: @escaping CompletionHandler, retryIfFail: Bool = true) {
        do {
                let url = urlCharacters
            
//                let input = "1" + kMarvelDeveloperPrivateKey + kMarvelDeveloperPublicKey
//                let digest = input.utf8.md5

                let params = [  "apikey":kMarvelDeveloperPublicKey,
                                "ts":"1",
                                "hash":"f967923ee6ff6aeab0ff03832144593f"] as [String : String]
            
            Just.get( url, params:params )
            { r in
                if r.ok
                {
                    let jsonCharsData = JSON(r.json!)

                    if jsonCharsData["data"]["results"].exists() {
                        let resultCount = jsonCharsData["data"]["count"].intValue
                        if resultCount > 0
                        {
                            for (_, charsInfo) in jsonCharsData["data"]["results"] {
                                
                                var dados = CharactersData()

                                if charsInfo["id"].exists() {
                                    dados.ID = charsInfo["id"].object as? Int
                                }

                                if charsInfo["name"].exists() {
                                    dados.name = charsInfo["name"].object as? String
                                }

                                if charsInfo["thumbnail"]["path"].exists() {
                                    dados.thumbnail = charsInfo["thumbnail"]["path"].object as? String
                                }

                                if charsInfo["thumbnail"]["extension"].exists() {
                                    dados.thumbnailExtension = charsInfo["thumbnail"]["extension"].object as? String
                                }
                                
                                charactersList.charactersListArray.append(dados)
                            }
                            if charactersList.charactersListArray.count > 0 {
                                completionHandler(true)
                            }
                        }
                    } else {
                        completionHandler(true)
                    }
                } else {
                    
                    print("getCharactersList: ERROR Reason\(r.reason)")
                    print("getCharactersList: ERROR Status\(r.statusCode ?? 0)")

                    if r.statusCode == 401 && retryIfFail {
                        
                    } else {
                        completionHandler(false)
                    }
                }
            }
        }
    }
//http://gateway.marvel.com/v1/public/characters/1011334/stories
    
    func getCharactersDetail( idCharacter: String, completionHandler: @escaping CompletionHandler, retryIfFail: Bool = true) {
        do {
            let url = "\(urlCharacters)/\(idCharacter)"
            
//            http://gateway.marvel.com/v1/public/comics/21366
            
            //                let input = "1" + kMarvelDeveloperPrivateKey + kMarvelDeveloperPublicKey
            //                let digest = input.utf8.md5
            
            let params = [  "apikey":kMarvelDeveloperPublicKey,
                            "ts":"1",
                            "hash":"f967923ee6ff6aeab0ff03832144593f"] as [String : String]
            
            Just.get( url, params:params )
            { r in
                if r.ok
                {
                    let jsonCharsData = JSON(r.json!)
                    
                    if jsonCharsData["data"]["results"].exists() {
                        let resultCount = jsonCharsData["data"]["count"].intValue
                        if resultCount > 0
                        {
                            for (_, charsInfo) in jsonCharsData["data"]["results"] {
                                
                                gCharactersComicData = CharactersComicData()
                                if charsInfo["comics"].exists() {
                                    if charsInfo["comics"]["available"].exists()
                                        && charsInfo["comics"]["available"]>0{
                                        if charsInfo["comics"]["items"].exists() {
                                            for ( index, comicItensInfo) in charsInfo["comics"]["items"] {
                                                if index == "0" {
                                                    gCharactersComicData.comicUrl = comicItensInfo["resourceURI"].object as? String
                                                    gCharactersComicData.statusComicReturn = "OK"
                                                    break
                                                }
                                            }
                                        }
                                    } else {
                                        gCharactersComicData.statusComicReturn = "Comic results not found!"
                                    }
                                }
                            }
                            if gCharactersComicData.comicUrl != nil {
                                completionHandler(true)
                            }
                        }
                    } else {
                        completionHandler(true)
                    }
                } else {
                    
                    print("getCharactersDetail: ERROR Reason\(r.reason)")
                    print("getCharactersDetail: ERROR Status\(r.statusCode ?? 0)")
                    
                    if r.statusCode == 401 && retryIfFail {
                        
                    } else {
                        completionHandler(false)
                    }
                }
            }
        }
    }
    
    func getCharactersComicItem( urlComicItem: String, completionHandler: @escaping CompletionHandler, retryIfFail: Bool = true) {
        do {
            let url = urlComicItem
            
            //            http://gateway.marvel.com/v1/public/comics/21366
            
            //                let input = "1" + kMarvelDeveloperPrivateKey + kMarvelDeveloperPublicKey
            //                let digest = input.utf8.md5
            
            let params = [  "apikey":kMarvelDeveloperPublicKey,
                            "ts":"1",
                            "hash":"f967923ee6ff6aeab0ff03832144593f"] as [String : String]
            
            Just.get( url, params:params )
            { r in
                if r.ok
                {
                    let jsonCharsData = JSON(r.json!)
                    
                    if jsonCharsData["data"]["results"].exists() {
                        let resultCount = jsonCharsData["data"]["count"].intValue
                        if resultCount > 0
                        {
                            for (_, charsInfo) in jsonCharsData["data"]["results"] {
                                
                                if charsInfo["id"].exists() {
                                    gCharactersComicData.ID = charsInfo["id"].object as? Int
                                }
                                
                                if charsInfo["title"].exists() {
                                    gCharactersComicData.title = charsInfo["title"].object as? String
                                }

                                if charsInfo["description"].exists() {
                                    
                                    if charsInfo["description"].string != nil {
                                        gCharactersComicData.description = charsInfo["description"].stringValue
                                    } else {
                                       gCharactersComicData.description = "Description not found"
                                    }
                                }

                                if charsInfo["thumbnail"]["path"].exists() {
                                    gCharactersComicData.thumbnail = charsInfo["thumbnail"]["path"].object as? String
                                }
                                
                                if charsInfo["thumbnail"]["extension"].exists() {
                                    gCharactersComicData.thumbnailExtension = charsInfo["thumbnail"]["extension"].object as? String
                                }

                                charactersComicList.charactersComicListArray.append(gCharactersComicData)
                            }
                            if charactersComicList.charactersComicListArray.count > 0 {
                                completionHandler(true)
                            }
                        }
                    } else {
                        completionHandler(true)
                    }
                } else {
                    
                    print("getCharactersComicItem: ERROR Reason\(r.reason)")
                    print("getCharactersComicItem: ERROR Status\(r.statusCode ?? 0)")
                    
                    if r.statusCode == 401 && retryIfFail {
                        
                    } else {
                        completionHandler(false)
                    }
                }
            }
        }
    }

}
