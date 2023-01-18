//
//  Viewer.swift
//  PokemonTest
//
//  Created by 劉柏賢 on 2022/6/25.
//

import Foundation

protocol Viewer: DataContextProtocol {
    associatedtype ViewModelType
    
    var viewModel: ViewModelType! { get set }
}

extension Viewer {
    var dataContext: Any? {
        get { viewModel }
        set { viewModel = newValue as? ViewModelType }
    }
}
