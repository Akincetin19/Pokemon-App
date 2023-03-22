//
//  PokemonCollectionViewModel.swift
//  Pokemon-App
//
//  Created by Akın Çetin on 20.03.2023.
//

import Foundation

protocol HomeScrenViewModelPokemonCollectionViewProtocol {
    
    var pokemonCollectionView: PokemonCollectionViewProtocol? {get set}
    func viewDidLoadCollectionView()
    func rowSelected(index: Int)
    func returnPokemonsCount() -> Int
    func getCurrentPokemonInfo(index: Int) -> PokemonInfo
}

extension HomeScreenViewModel: HomeScrenViewModelPokemonCollectionViewProtocol {
    
    func viewDidLoadCollectionView() {
        self.pokemonCollectionView?.confiureCollectionView()
    }
    
    func rowSelected(index: Int) {
        self.view?.goToDetailPage(pokemonInfo: self.getCurrentPokemonInfo(index: index))
    }
    func returnPokemonsCount() -> Int {
        return getItemCount(array: pokemonsInfo)
    }
    func getCurrentPokemonInfo(index: Int) -> PokemonInfo {
        return pokemonsInfo[index]
    }
}

