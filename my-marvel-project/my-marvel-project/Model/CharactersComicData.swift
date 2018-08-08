//
//  CharactersData.swift
//  my-marvel-project
//
//  Created by Alexandre Gabassi on 08/08/18.
//  Copyright © 2018 Alexandre Gabassi. All rights reserved.
//

import Foundation

struct CharactersComicData {
    var ID: Int? = 0
    var title: String? = ""
    var description: String? = ""
    var thumbnail: String? = ""
    var thumbnailExtension: String? = ""
    var comicUrl: String? = ""
    var statusComicReturn: String? = ""

    func toDictionary() -> [String: Any] {
        var currentDictionary = [String: Any]()
        currentDictionary["ID"] = ID
        currentDictionary["title"] = title
        currentDictionary["description"] = description
        currentDictionary["thumbnail"] = thumbnail
        currentDictionary["thumbnailExtension"] = thumbnailExtension
        currentDictionary["comicUrl"] = comicUrl
        currentDictionary["statusComicReturn"] = statusComicReturn

        return currentDictionary
    }
}

class CharactersComic {
    
    static let sharedCharacters = CharactersComic()
    
    var charactersComicListArray:[CharactersComicData] = []
}


