//
//  ViewController.swift
//  Pokemon-App
//
//  Created by Akın Çetin on 20.03.2023.
//

import UIKit
import JGProgressHUD

protocol HomeScreenProtocol: AnyObject {
    
    func goToDetailPage(pokemonInfo: PokemonInfo)
    func configureView()
    func endProgressHud()
}

final class HomeScreen: UIViewController {

    var viewModel: HomeScreenViewModelProtocol?
    
    let progresHud = JGProgressHUD()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = HomeScreenViewModel()
        viewModel?.view = self
        viewModel?.viewDidLoad()
        startProgressHud()

    }
    lazy var layout: UICollectionViewFlowLayout = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            return layout
        }()
    fileprivate func configureNavigationController() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = "Pokedex"
    }
    private func addCollectionView() {
        lazy var pokemonCollectionView = PokemonCollectionView(frame: .zero, collectionViewLayout: layout, viewModel: viewModel as! HomeScrenViewModelPokemonCollectionViewProtocol)
        view.addSubview(pokemonCollectionView)
        pokemonCollectionView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 16, left: 16, bottom: 0, right: 16))
    }
    fileprivate func startProgressHud() {
        progresHud.textLabel.text = "Loading"
        progresHud.cornerRadius = 16
        progresHud.style = .dark
        progresHud.show(in: self.view)
    }
}
extension HomeScreen: HomeScreenProtocol {
    
    func goToDetailPage(pokemonInfo: PokemonInfo) {
        let vc = PokemonDetailScreen(pokemonInfo: pokemonInfo)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func configureView() {
        view.backgroundColor = .white
        configureNavigationController()
        
        addCollectionView()
        
    }
    func endProgressHud() {
        progresHud.dismiss(animated: true)
    }
}

