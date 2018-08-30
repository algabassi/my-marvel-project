//
//  Constants.swift
//  my-marvel-project
//
//  Created by Alexandre Gabassi on 07/08/18.
//  Copyright © 2018 Alexandre Gabassi. All rights reserved.
//

import Foundation


let baseURL = "https://gateway.marvel.com/"
let urlCharacters = "\(baseURL)v1/public/characters"

let kMarvelDeveloperPublicKey = "" 
let kMarvelDeveloperPrivateKey = ""

var charactersList = Characters.sharedCharacters
var charactersComicList = CharactersComic.sharedCharacters
var gCharactersComicData = CharactersComicData()
let gCharactersRequests = wsRequests()

var flagCharactersListLoadSuccess = false

