//
//  PokemonCellViewModel.swift
//  Pokemon-App
//
//  Created by Akın Çetin on 20.03.2023.
//

import UIKit

protocol PokemonCollectionViewModelCellProtocol {
    
    var cellView: PokemonCellProtocol? {get set}
    func getPokemonInfo(index: Int) -> PokemonInfo
    func cellViewDidLoad()
    func getPokemonSpecies(index: Int, url: String, completion: @escaping (PokemonSpecies) -> ())
    
}

extension HomeScreenViewModel: PokemonCollectionViewModelCellProtocol {
    func cellViewDidLoad() {
        self.cellView?.viewDidload()
    }
    func getPokemonSpecies(index: Int, url: String, completion: @escaping (PokemonSpecies) -> ()) {
        pokemonService.fetchData(url: url) { (result: Result<PokemonSpecies, Error>) in
            
            switch result {
            case.success(let data):
                completion(data)
                self.pokemonsInfo[index].polemonSpecies = data
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    func getPokemonInfo(index: Int) -> PokemonInfo {
        return getItemAtIndex(array: pokemonsInfo, index: index)
    }
    
}
