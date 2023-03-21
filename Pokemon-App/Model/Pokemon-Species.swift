//
//  Pokemon-Species.swift
//  Pokemon-App
//
//  Created by Akın Çetin on 21.03.2023.
//

import Foundation

struct PokemonSpecies: Codable {
    let color: Color?
}

// MARK: - Color
struct Color: Codable {
    let name: String?
    let url: String?
}
