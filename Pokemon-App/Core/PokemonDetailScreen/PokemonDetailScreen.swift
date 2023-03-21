//
//  PokemonDetailScreen.swift
//  Pokemon-App
//
//  Created by Akın Çetin on 21.03.2023.
//

import UIKit

final class PokemonDetailScreen: UIViewController {

    
    var pokemonInfo: PokemonInfo
    init(pokemonInfo: PokemonInfo) {
        
        self.pokemonInfo = pokemonInfo
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .red
        print(self.pokemonInfo.name)
    }
    

    

}
