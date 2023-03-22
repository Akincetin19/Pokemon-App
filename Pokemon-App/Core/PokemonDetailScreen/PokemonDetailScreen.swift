//
//  PokemonDetailScreen.swift
//  Pokemon-App
//
//  Created by Akın Çetin on 21.03.2023.
//

import UIKit
import SVGKit

protocol PokemonDetailScreenProtocol: AnyObject {
    func configurePokemonDetailScreen()
}
protocol PokemonDetail {
    func configureNavigationTitle()
    func addPokemonImage()
    func addInfoView()
    func createLabel(text: String) -> UILabel
}
final class PokemonDetailScreen: UIViewController {

    var viewModel: PokemonDetailScreenViewModelProtocol?
    let pokemonImage: UIImageView = UIImageView(frame: .zero)
    let infoView = UIView(frame: .zero)
    let abilitiesLabel = UILabel(frame: .zero)

    let aboutLabel :UILabel = {
       
        let label = UILabel(frame: .zero)
        label.text = "About"
        label.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        return label
    }()
    init(pokemonInfo: PokemonInfo) {
        viewModel = PokemonDetailScreenViewModel()
        viewModel?.pokemonInfo = pokemonInfo
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.view = self
        viewModel?.viewDidLoad()
    }    
}
extension PokemonDetailScreen: PokemonDetailScreenProtocol {
    func configurePokemonDetailScreen() {
        view.backgroundColor = StringToColor.convertStringToColor(color: self.viewModel?.pokemonInfo?.pokemonSpecies?.color?.name ?? "")
        configureNavigationTitle()
        addPokemonImage()
        addInfoView()
        addAboutLabel()
        addAboutView()
    }
}
extension PokemonDetailScreen: PokemonDetail {
    func addAboutView() {
        let aboutView = AboutUIView(pokemonInfo: self.viewModel!.pokemonInfo!)
        view.addSubview(aboutView)
        aboutView.anchor(top: aboutLabel.bottomAnchor, leading: infoView.leadingAnchor, bottom: infoView.bottomAnchor, trailing: infoView.trailingAnchor, padding: .init(top: 16, left: 32, bottom: 0, right: 0))
    }
    func configureNavigationTitle() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        guard let pokemonName = viewModel?.pokemonInfo?.name?.capitalized else {return}
        navigationItem.title = pokemonName
        
    }
    func addPokemonImage() {
        view.addSubview(pokemonImage)
        self.pokemonImage.image = self.viewModel?.pokemonInfo?.svgImage?.uiImage.withRenderingMode(.alwaysOriginal)
        pokemonImage.contentMode = .scaleAspectFill
        pokemonImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 100, bottom: 0, right: 0), size: .init(width: 200, height: 320))
        view.addSubview(infoView)
        pokemonImage.layer.zPosition = 1
    }
    
    func addInfoView() {
        infoView.backgroundColor = .white
        infoView.anchor(top: pokemonImage.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: -32, left: 0, bottom: 0, right: 0))
        infoView.layer.cornerRadius = 32
    }
    func addAboutLabel() {
        view.addSubview(aboutLabel)
        aboutLabel.anchor(top: infoView.topAnchor, leading: infoView.leadingAnchor, bottom: nil, trailing: infoView.trailingAnchor, padding: .init(top: 32, left: 32, bottom: 0, right: 0))
    }
    func createLabel(text: String) -> UILabel {
        
        let label = UILabel(frame: .zero)
        label.text = text.capitalized
        label.sizeThatFits(.init(width: view.frame.width, height: 50))
        label.numberOfLines = 0
        return label
    }
}
