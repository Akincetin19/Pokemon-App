//
//  HomeScreenViewModel.swift
//  Pokemon-App
//
//  Created by Akın Çetin on 20.03.2023.
//
import Foundation
import SVGKit

protocol HomeScreenViewModelProtocol {
    
    var view: HomeScreenProtocol? {get set}
    func viewDidLoad()
}
protocol HomeViewModelPrivateProtocol {
    
    func downloadPokemons()
    func downloadPokemonsInfo()
    func downloadImageData()
    func downloadPokemonColorInfo(index: Int)
    func getItemCount<T>(array: [T]) -> Int
    func getItemAtIndex<T>(array: [T], index: Int) -> T
    func handleWithResult<T>(result: Result<T, Error>) -> T?
    
}
final class HomeScreenViewModel {
    
    weak var pokemonCollectionView: PokemonCollectionViewProtocol?
    weak var view: HomeScreenProtocol?
    private let pokemonService = PokemonService()
    private var pokemons: [Pokemon] = [Pokemon]()
    var pokemonsInfo: [PokemonInfo] = [PokemonInfo]()
    
    private let group = DispatchGroup()
    private let queue = DispatchQueue.global(qos: .userInitiated)
}
extension HomeScreenViewModel: HomeScreenViewModelProtocol {
    
    func viewDidLoad() {
        self.downloadPokemons()
        self.view?.configureView()
    }
}
extension HomeScreenViewModel: HomeViewModelPrivateProtocol {
    func getItemCount<T>(array: [T]) -> Int {
        return array.count
    }

    func getItemAtIndex<T>(array: [T], index: Int) -> T {
        return array[index]
    }
    func downloadPokemons() {
        pokemonService.fetchData(url: APIURLs.getAllPokemonUrl()) {[weak self] (result: Result<PokemonResponse, Error>) in
            
            guard let self = self , let pokemonsResponse = self.handleWithResult(result: result),
            let pokemons = pokemonsResponse.results else {return}
            self.pokemons.append(contentsOf: pokemons)
            self.downloadPokemonsInfo()
        }
    }
    func downloadPokemonsInfo() {

        var results: [PokemonInfo] = []
        pokemons.forEach { pokemon in
            guard let pokemonUrl = pokemon.url else {return}
            group.enter()
            queue.async {
                self.pokemonService.fetchData(url: pokemonUrl) {[weak self] (result: Result<PokemonInfo, Error>) in
                    guard let self = self,let pokemonInfo = self.handleWithResult(result: result) else {return}
                    results.append(pokemonInfo)
                    self.group.leave()
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
        
        for index in stride(from: 0, to: self.pokemons.count, by: 1) {
            self.downloadPokemonColorInfo(index: index)
            guard let url = pokemonsInfo[index].sprites?.other?.dreamWorld?.frontDefault else {return}
            group.enter()
            pokemonService.fetchImageData(url: url) {[weak self] result in
                
                guard let self = self , let data = self.handleWithResult(result: result) else {return}
                let svgImage = SVGKImage(data: data)
                self.pokemonsInfo[index].svgImage = svgImage
                self.group.leave()
            }
        }
        group.notify(queue: .main) {
            self.view?.endProgressHud()
            self.pokemonCollectionView?.reloadTableView()
        }
    }
    func downloadPokemonColorInfo(index: Int) {
        
        guard let urlString = pokemonsInfo[index].species?.url else {return}
        pokemonService.fetchData(url: urlString) {[weak self] (result: Result<PokemonSpecies, Error>) in
            
            guard let self = self , let pokemonSpecies = self.handleWithResult(result: result) else {return}
            self.pokemonsInfo[index].pokemonSpecies = pokemonSpecies
        }
    }
    @discardableResult
    func handleWithResult<T>(result: Result<T, Error>) -> T?{
        
        switch result {
        case.failure(let error):
            print(error)
        case.success(let value):
            return value
        }
        return nil
    }
}
