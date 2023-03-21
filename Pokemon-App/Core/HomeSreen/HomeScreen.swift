//
//  ViewController.swift
//  Pokemon-App
//
//  Created by Akın Çetin on 20.03.2023.
//

import UIKit

protocol HomeScreenProtocol: AnyObject {
    
    func goToDetailPage(pokemonInfo: PokemonInfo)
    func configureView()
}

final class HomeScreen: UIViewController {

    lazy var layout: UICollectionViewFlowLayout = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            return layout
        }()
    var viewModel: HomeScreenViewModelProtocol?
    let service = PokemonService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = HomeScreenViewModel()
        
        viewModel?.view = self
        viewModel?.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = "Pokedex"
    }
    private func addCollectionView() {
        lazy var pokemonCollectionView = PokemonCollectionView(frame: .zero, collectionViewLayout: layout, viewModel: viewModel as! HomeScrenViewModelPokemonCollectionViewProtocol)
        view.addSubview(pokemonCollectionView)
        pokemonCollectionView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 16, left: 16, bottom: 0, right: 16))
    }
}
extension HomeScreen: HomeScreenProtocol {
    
    func goToDetailPage(pokemonInfo: PokemonInfo) {
        
        let vc = PokemonDetailScreen(pokemonInfo: pokemonInfo)
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func configureView() {
        view.backgroundColor = .white
        addCollectionView()
    }
}

