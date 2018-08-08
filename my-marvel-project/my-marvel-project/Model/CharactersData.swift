//
//  CharactersData.swift
//  my-marvel-project
//
//  Created by Alexandre Gabassi on 08/08/18.
//  Copyright © 2018 Alexandre Gabassi. All rights reserved.
//

import Foundation

struct CharactersData {
    var ID: Int? = 0
    var name: String? = ""
    var thumbnail: String? = ""
    var thumbnailExtension: String? = ""
    var comicUrl: String? = ""

    func toDictionary() -> [String: Any] {
        var currentDictionary = [String: Any]()
        currentDictionary["ID"] = ID
        currentDictionary["name"] = name
        currentDictionary["thumbnail"] = thumbnail
        currentDictionary["thumbnailExtension"] = thumbnailExtension
        currentDictionary["comicUrl"] = comicUrl
        return currentDictionary
    }
}

class Characters {
    
    static let sharedCharacters = Characters()
    
    var charactersListArray:[CharactersData] = []
}


