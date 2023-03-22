//
//  PokemonCollectionViewCell.swift
//  Pokemon-App
//
//  Created by Akın Çetin on 20.03.2023.
//

import UIKit
import SVGKit

final class PokemonCollectionViewCell: UICollectionViewCell {
    
    private var indexPath : Int = 0
    let PokemonNameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .right
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.layer.zPosition = 1
        return label
    }()
    
    let pokemonImageView = UIImageView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewDidload()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    fileprivate func updateCellImageAndLabel(pokemonInfo: PokemonInfo) {
        
        self.PokemonNameLabel.text = pokemonInfo.name?.capitalized
        let image = pokemonInfo.svgImage?.uiImage
        image?.withRenderingMode(.alwaysOriginal)
        self.pokemonImageView.contentMode = .scaleAspectFit
        self.pokemonImageView.image = image
        
    }
    fileprivate func updateCellBackgroundColor(pokemonInfo: PokemonInfo) {
        
        self.backgroundColor = StringToColor.convertStringToColor(color: pokemonInfo.pokemonSpecies?.color?.name ?? "")
    }
    func configureCell(pokemonInfo: PokemonInfo) {

        updateCellImageAndLabel(pokemonInfo: pokemonInfo)
        updateCellBackgroundColor(pokemonInfo: pokemonInfo)
        
    }
    func viewDidload() {
        layer.cornerRadius = 16

        addSubview(PokemonNameLabel)
        PokemonNameLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 16, left: 0, bottom: 0, right: 16))
        addSubview(pokemonImageView)
        pokemonImageView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 34, left: 0, bottom: 16, right: 0), size: .init(width: 125, height: 100))
        
        backgroundColor = UIColor(red: 249/255, green: 245/255, blue: 235/255, alpha: 1)
    }
}

