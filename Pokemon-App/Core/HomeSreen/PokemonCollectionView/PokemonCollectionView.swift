//
//  PokemonCollectionView.swift
//  Pokemon-App
//
//  Created by Akın Çetin on 20.03.2023.
//

import UIKit

protocol PokemonCollectionViewProtocol: AnyObject {
    
    func confiureCollectionView()
    func reloadTableView()
}

final class PokemonCollectionView: UICollectionView {

    private var viewModel: HomeScrenViewModelPokemonCollectionViewProtocol?
    
    init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout, viewModel: HomeScrenViewModelPokemonCollectionViewProtocol) {
        self.viewModel = viewModel
        super.init(frame: frame, collectionViewLayout: layout)
        self.viewModel?.pokemonCollectionView = self
        self.viewModel?.viewDidLoadCollectionView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension PokemonCollectionView: PokemonCollectionViewProtocol {
    func confiureCollectionView() {
        
        delegate = self
        dataSource = self
        register(PokemonCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        showsVerticalScrollIndicator = false
    }
    func reloadTableView() {
        self.reloadData()
    }
}
extension PokemonCollectionView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel?.rowSelected(index: indexPath.row)
    }
    
}
extension PokemonCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = viewModel?.returnPokemonsCount() else {return 0}
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PokemonCollectionViewCell
        guard let pokemonInfo = viewModel?.getCurrentPokemonInfo(index: indexPath.row) else {return PokemonCollectionViewCell()}
        cell.configureCell(pokemonInfo: pokemonInfo)
        return cell
    }
}
extension PokemonCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (frame.width - 10) / 2
        return CGSize(width: width, height: 150)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
