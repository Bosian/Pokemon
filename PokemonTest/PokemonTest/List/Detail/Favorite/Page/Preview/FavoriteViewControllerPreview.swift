//
//  FavoriteViewControllerPreview.swift
//  PokemonTest
//
//  Created by 劉柏賢 on 2022/6/27.
//

import UIKit
import SwiftUI

struct FavoriteViewControllerPreview: UIViewRepresentable {

    private static func getModel(json: String) -> PokemonListModel.Result? {
		return PokemonListModel.Result(json: json)
    }
    
    let viewController: UIViewController
    
    init() {
        let storyboard = UIStoryboard(name: "FavoriteStoryboard", bundle: Bundle.main)
        let viewController = storyboard.instantiateInitialViewController()!
        self.viewController = viewController

        let model1 = Self.getModel(json:
        #"""
        {
            "name":"bulbasaur",
            "url":"https://pokeapi.co/api/v2/pokemon/1/"
        }
        """#
		)
        
        let model2 = Self.getModel(json:
        #"""
        {
            "name": "ivysaur",
            "url": "https://pokeapi.co/api/v2/pokemon/2/"
        }
        """#)

        let model3 = Self.getModel(json:
        #"""
        {
            "name": "venusaur",
            "url": "https://pokeapi.co/api/v2/pokemon/3/"
        }
        """#)

        FavoriteManager.shared.toggleFavorite(model: model1)
        FavoriteManager.shared.toggleFavorite(model: model3)
        FavoriteManager.shared.toggleFavorite(model: model2)
    }
    
    func makeUIView(context: Context) -> some UIView {
        return viewController.view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
}

struct FavoriteViewController_Preview: PreviewProvider {
    static var previews: some View {
        FavoriteViewControllerPreview()
    }
}
