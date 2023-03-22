//
//  APIURLs.swift
//  Pokemon-App
//
//  Created by Akın Çetin on 20.03.2023.
//

import Foundation

enum APIURLs {
    
    static func getAllPokemonUrl() -> String {
        
        return "https://pokeapi.co/api/v2/pokemon?offset=0&limit=40"
    }
}
