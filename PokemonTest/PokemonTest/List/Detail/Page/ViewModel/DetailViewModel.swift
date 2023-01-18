//
//  DetailViewModel.swift
//  PokemonTest
//
//  Created by 劉柏賢 on 2022/6/27.
//

import Foundation
import RxCocoa
import UIKit

final class DetailViewModel {
    
    let model: BehaviorRelay<PokemonDetailModel?> = BehaviorRelay<PokemonDetailModel?>(value: nil)
    
    let isUpdate: BehaviorRelay<Bool> = BehaviorRelay<Bool>(value: true)
    
    var favoriteIcon: UIImage {
        let image: UIImage = FavoriteManager.shared.isFavorite(model: navigationParameter.model) ? UIImage(systemName: "heart.fill")! : UIImage(systemName: "heart")!
        return image
    }
    
    typealias NavigationParameterType = DetailNavigationParameter
    let navigationParameter: NavigationParameterType
    
    init(navigationParameter: NavigationParameterType) {
        self.navigationParameter = navigationParameter
        refresh()
    }
    
    private func refresh() {
        
        Task {
            isUpdate.accept(true)
            
            let parameter = PokemonDetailParameter()
            let model = try await callPokemonDetailWebAPI(url: navigationParameter.model.url, parameter: parameter)
            
            isUpdate.accept(false)
            
            self.model.accept(model)
        }
    }
    
    private func callPokemonDetailWebAPI(url: String, parameter: PokemonDetailParameter) async throws -> PokemonDetailModel {
        return try await PokemonDetailWebAPI(urlString: url).invokeAsync(parameter)
    }
}
