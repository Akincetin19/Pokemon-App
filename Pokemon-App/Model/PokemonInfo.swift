//
//  PokemonInfo.swift
//  Pokemon-App
//
//  Created by Akın Çetin on 20.03.2023.
//

import Foundation
import SVGKit

struct PokemonInfo: Codable {
    let abilities: [Ability]?
    let height: Int?
    let locationAreaEncounters: String?
    let name: String?
    let order: Int?
    let id: Int?
    let species: Species?
    let sprites: Sprites?
    let weight: Int?
    var image: Data?
    var svgImage: SVGKImage?
    var pokemonSpecies: PokemonSpecies?

    enum CodingKeys: String, CodingKey {
        case id
        case abilities
        case height
        case locationAreaEncounters = "location_area_encounters"
        case name, order
        case species, sprites, weight
    }
}

struct Species: Codable {
    let name: String?
    let url: String?
}
struct Ability: Codable {
    let ability: Species?
    let isHidden: Bool?
    let slot: Int?

    enum CodingKeys: String, CodingKey {
        case ability
        case isHidden = "is_hidden"
        case slot
    }
}
class Sprites: Codable {
    
    let other: Other?

    enum CodingKeys: String, CodingKey {
        case other
    }
}
struct Other: Codable {
    let dreamWorld: DreamWorld?
    let home: Home?
    enum CodingKeys: String, CodingKey {
        case home
        case dreamWorld = "dream_world"
    }
}
struct DreamWorld: Codable {
    let frontDefault: String?
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

struct Home: Codable {
    let frontDefault: String?
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}
