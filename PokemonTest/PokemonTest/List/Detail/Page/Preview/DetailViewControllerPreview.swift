//
//  DetailViewControllerPreview.swift
//  PokemonTest
//
//  Created by 劉柏賢 on 2022/6/27.
//

import UIKit
import SwiftUI

struct DetailViewControllerPreview: UIViewRepresentable {

    let viewController: UIViewController
    
    init() {
        let storyboard = UIStoryboard(name: "DetailStoryboard", bundle: Bundle.main)
        let viewController = storyboard.instantiateInitialViewController() as! (ParameterDelegate & UIViewController)
        let listModel = PokemonListModel.Result(json:
            #"""
            {
              "name": "bulbasaur",
              "url": "https://pokeapi.co/api/v2/pokemon/1/"
            }
            """#
        )
        
        guard let listModel = listModel else {
            let viewController = UIViewController()
            viewController.view.backgroundColor = UIColor.orange
            self.viewController = viewController
            return
        }
        
        let navigationParameter = DetailNavigationParameter(model: listModel)
        viewController.setParameter(navigationParameter)
        
        self.viewController = viewController
    }
    
    func makeUIView(context: Context) -> some UIView {
        return viewController.view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
}

struct DetailViewController_Preview: PreviewProvider {
    static var previews: some View {
        DetailViewControllerPreview()
    }
}


//        let json: String = #"""
//         {
//           "id": 1111,
//           "weight": 70,
//           "height": 175,
//           "sprite": {
//             "front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/6.png"
//           },
//           "types": [
//             {
//               "type": {
//                 "name": "fire",
//                 "url": "https://pokeapi.co/api/v2/type/10/"
//               }
//             },
//             {
//               "type": {
//                 "name": "flying",
//                 "url": "https://pokeapi.co/api/v2/type/3/"
//               }
//             }
//           ]
//         }
//         """#
