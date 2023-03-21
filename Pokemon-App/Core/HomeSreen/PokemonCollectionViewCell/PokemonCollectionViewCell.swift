//
//  PokemonCollectionViewCell.swift
//  Pokemon-App
//
//  Created by Akın Çetin on 20.03.2023.
//

import UIKit

protocol PokemonCellProtocol: AnyObject {
    func viewDidload()
}

final class PokemonCollectionViewCell: UICollectionViewCell {
    
    private var indexPath : Int = 0
    var viewModel: PokemonCollectionViewModelCellProtocol?
    let PokemonNameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .right
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.text = ""
        label.layer.zPosition = 1
        return label
    }()
    let pokemonImageView = UIImageView(frame: .zero)
   
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    fileprivate func updateCellImageAndLabel(pokemonInfo: PokemonInfo) {
        
        self.PokemonNameLabel.text = pokemonInfo.name
        let image = UIImage(data: pokemonInfo.image!)
        image?.withRenderingMode(.alwaysOriginal)
        self.pokemonImageView.contentMode = .scaleAspectFill
        self.pokemonImageView.image = image
    }
    fileprivate func updateCellBackgroundColor(pokemonInfo: PokemonInfo) {
        
        DispatchQueue.global(qos: .userInitiated).async {
            guard let urlString = pokemonInfo.species?.url else {return}
            self.viewModel?.getPokemonSpecies(index: self.indexPath,url: urlString, completion: { pokemonSpecies in
                DispatchQueue.main.async {
                    self.backgroundColor = StringToColor.convertStringToColor(color: (pokemonSpecies.color?.name)!)
                }
            })
        }
    }
    func configureCell() {

        let pokemonInfo = viewModel?.getPokemonInfo(index: indexPath)
        guard let pokemonInfo = pokemonInfo else {return}
        updateCellImageAndLabel(pokemonInfo: pokemonInfo)
        updateCellBackgroundColor(pokemonInfo: pokemonInfo)
        
    }
    func configureCellViewModel(viewModel: PokemonCollectionViewModelCellProtocol, indexPath: Int) {
        self.viewModel = viewModel
        self.viewModel?.cellView = self
        viewModel.cellViewDidLoad()
        self.indexPath = indexPath
        configureCell()
    }
}
extension PokemonCollectionViewCell: PokemonCellProtocol {
    func viewDidload() {
        layer.cornerRadius = 16
        addSubview(PokemonNameLabel)
        PokemonNameLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 16, left: 0, bottom: 0, right: 16))
        addSubview(pokemonImageView)
        pokemonImageView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 34, left: 0, bottom: 16, right: 0), size: .init(width: 125, height: 100))
        
        backgroundColor = UIColor(red: 249/255, green: 245/255, blue: 235/255, alpha: 1)
    }
}

