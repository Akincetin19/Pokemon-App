//
//  PokemonDetailScreenViewModel.swift
//  Pokemon-App
//
//  Created by Akın Çetin on 22.03.2023.
//

import Foundation

protocol PokemonDetailScreenViewModelProtocol {
    
    var view: PokemonDetailScreenProtocol? {get set}
    var pokemonInfo: PokemonInfo? {get set}
    func viewDidLoad()
}

final class PokemonDetailScreenViewModel {
    
    weak var view: PokemonDetailScreenProtocol?
    
    var pokemonInfo: PokemonInfo?
}

extension PokemonDetailScreenViewModel: PokemonDetailScreenViewModelProtocol {
    
    func viewDidLoad() {
        view?.configurePokemonDetailScreen()
    }
}
