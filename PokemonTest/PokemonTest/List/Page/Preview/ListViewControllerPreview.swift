//
//  ListViewControllerPreview.swift
//  PokemonTest
//
//  Created by 劉柏賢 on 2022/6/27.
//

import UIKit
import SwiftUI

struct ListViewControllerPreview: UIViewRepresentable {

    let viewController: UIViewController

    init() {
        let storyboard = UIStoryboard(name: "ListStoryboard", bundle: Bundle.main)
        let viewController = storyboard.instantiateInitialViewController()!
        self.viewController = viewController
    }

    func makeUIView(context: Context) -> some UIView {
        return viewController.view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
}

struct ListViewController_Preview: PreviewProvider {
    static var previews: some View {
        ListViewControllerPreview()
    }
}
