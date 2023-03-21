//
//  Pokemon.swift
//  Pokemon-App
//
//  Created by Akın Çetin on 20.03.2023.
//

import Foundation

// MARK: - Pokemon
struct PokemonResponse: Codable {
    let count: Int?
    let next, previous: String?
    let results: [Pokemon]?
}

// MARK: - Result
struct Pokemon: Codable {
    let name: String?
    let url: String?
}
