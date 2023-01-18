//
//  ListCellViewModel.swift
//  PokemonTest
//
//  Created by 劉柏賢 on 2022/6/27.
//

import UIKit

struct ListCellViewModel {
    let favoriteModel: FavoriteModel?
    let model: PokemonListModel.Result
    
    var favoriteIcon: UIImage {
        let image: UIImage = FavoriteManager.shared.isFavorite(model: model) ? UIImage(systemName: "heart.fill")! : UIImage(systemName: "heart")!
        return image
    }
    
    init(favoriteModel: FavoriteModel) {
        self.favoriteModel = favoriteModel
        self.model = favoriteModel.model
    }
        
    init(model: PokemonListModel.Result) {
        self.favoriteModel = nil
        self.model = model
    }
}
