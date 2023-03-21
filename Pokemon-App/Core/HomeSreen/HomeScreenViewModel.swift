//
//  HomeScreenViewModel.swift
//  Pokemon-App
//
//  Created by Akın Çetin on 20.03.2023.
//

import Foundation


protocol HomeScreenViewModelProtocol {
    
    var view: HomeScreenProtocol? {get set}
    func viewDidLoad()
}
protocol HomeScreenViewModelPrivateProtocol {
    
    func downloadPokemons()
    func downloadPokemonsInfo()
    func downloadImageData()
    func getItemCount<T>(array: [T]) -> Int
    func getItemAtIndex<T>(array: [T], index: Int) -> T
}

final class HomeScreenViewModel {
    
    weak var pokemonCollectionView: PokemonCollectionViewProtocol?
    weak var view: HomeScreenProtocol?
    weak var cellView: PokemonCellProtocol?
    let pokemonService = PokemonService()
    
    var pokemons: [Pokemon] = [Pokemon]()
    var pokemonsInfo: [PokemonInfo] = [PokemonInfo]()
}
extension HomeScreenViewModel: HomeScreenViewModelProtocol {
    
    func viewDidLoad() {
        self.downloadPokemons()
        self.view?.configureView()
    }
}
extension HomeScreenViewModel: HomeScreenViewModelPrivateProtocol {
    func getItemCount<T>(array: [T]) -> Int {
        return array.count
    }

    func getItemAtIndex<T>(array: [T], index: Int) -> T {
        return array[index]
    }
    func downloadPokemons() {
        pokemonService.fetchData(url: APIURLs.getAllPokemonUrl()) { (result: Result<PokemonResponse, Error>) in
            switch result {
            case.failure(let error):
                print(error.localizedDescription)
            case.success(let response):
                guard let pokemons = response.results else {return}
                self.pokemons.append(contentsOf: pokemons)
                self.downloadPokemonsInfo()
            }
        }
    }
    func downloadPokemonsInfo() {

        let group = DispatchGroup()
        var results: [PokemonInfo] = []
        let queue = DispatchQueue.global(qos: .userInitiated)
        pokemons.forEach { pokemon in
            guard let pokemonUrl = pokemon.url else {return}
            group.enter()
            queue.async {
                self.pokemonService.fetchData(url: pokemonUrl) { (result: Result<PokemonInfo, Error>) in
                    switch result {
                    case.failure(let error):
                        print(error.localizedDescription)
                    case.success(let response):
                        let pokemonInfo: PokemonInfo = response
                        
                        results.append(pokemonInfo)
                    }
                    group.leave()
                }
            }

        }
        group.notify(queue: .main) {
            results.sort {$0.id! < $1.id!}
            self.pokemonsInfo.append(contentsOf: results)
            self.downloadImageData()
        }
    }
    func downloadImageData() {
        let group = DispatchGroup()
        for index in stride(from: 0, to: self.pokemons.count, by: 1) {
            guard let url = pokemonsInfo[index].sprites?.other?.home?.frontDefault else {return}
            group.enter()
            pokemonService.fetchImageData(url: url) { result in
                
                switch result {
                case.failure(let error):
                    print(error.localizedDescription)
                case.success(let data):
                    self.pokemonsInfo[index].image = data
                }
                group.leave()
            }
        }
        group.notify(queue: .main) {
            self.pokemonCollectionView?.reloadTableView()
        }
    }
    
}
