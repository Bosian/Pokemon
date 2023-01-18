//
//  ListCell.swift
//  PokemonTest
//
//  Created by 劉柏賢 on 2022/6/27.
//

import UIKit

final class ListCell: UITableViewCell, Viewer {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var favoriteButon: UIButton!
    
    typealias ViewModelType = ListCellViewModel
    var viewModel: ViewModelType! {
        didSet {
            label.text = viewModel.model.name
            favoriteButon.setImage(viewModel.favoriteIcon, for: UIControl.State.normal)
        }
    }

    @IBAction func onFavoriteTapped(_ sender: UIButton) {
        FavoriteManager.shared.toggleFavorite(model: viewModel.model)
        favoriteButon.setImage(viewModel.favoriteIcon, for: UIControl.State.normal)
    }
}
