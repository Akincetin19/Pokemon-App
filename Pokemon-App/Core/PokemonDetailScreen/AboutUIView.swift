//
//  AboutUIView.swift
//  Pokemon-App
//
//  Created by Akın Çetin on 22.03.2023.
//

import UIKit

class AboutUIView: UIView {

    
    var pokemonInfo: PokemonInfo
    init(pokemonInfo: PokemonInfo) {
        self.pokemonInfo = pokemonInfo
        super.init(frame: .zero)
        
        var abilities: String = ""
        
        pokemonInfo.abilities?.forEach({ ability in
            abilities += ability.ability?.name ?? ""
            abilities += ","
        })
        abilities.removeLast()
        let titleStackView = UIStackView(arrangedSubviews: [createLabelView(text: "ID", color: .lightGray),createLabelView(text: "Species", color: .lightGray), createLabelView(text: "Height", color: .lightGray), createLabelView(text: "Weight", color: .lightGray), createLabelView(text: "Abilities", color: .lightGray)])
        addSubview(titleStackView)
        titleStackView.axis = .vertical
        titleStackView.spacing = 20
        titleStackView.distribution = .equalSpacing
        titleStackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, size: .init(width: 100, height: 0))
        
        let valueStackView = UIStackView(arrangedSubviews: [ createLabelView(text: ("\(pokemonInfo.id!)"), color: .black),createLabelView(text: pokemonInfo.species?.name ?? "", color: .black), createLabelView(text: "\(pokemonInfo.height!)", color: .black), createLabelView(text: "\(pokemonInfo.weight!)", color: .black), createLabelView(text: abilities, color: .black)])
        addSubview(valueStackView)
        valueStackView.axis = .vertical
        valueStackView.spacing = 20
        valueStackView.distribution = .equalSpacing
        valueStackView.anchor(top: topAnchor, leading: titleStackView.trailingAnchor, bottom: nil, trailing: trailingAnchor)
        
    }
    fileprivate func createLabelView(text: String, color: UIColor) -> UILabel {
        let label = UILabel(frame: .zero)
        label.text = text.capitalized
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = color
        return label
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
