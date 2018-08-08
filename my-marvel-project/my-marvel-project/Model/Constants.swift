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

let kMarvelDeveloperPublicKey = "e9b7152fc8a86368f93ea7e04cf33f78"
let kMarvelDeveloperPrivateKey = "98afb987551cd3ee00850971d1f4029f39d68868"

var charactersList = Characters.sharedCharacters
var charactersComicList = CharactersComic.sharedCharacters
var gCharactersComicData = CharactersComicData()
let gCharactersRequests = wsRequests()

var flagCharactersListLoadSuccess = false

