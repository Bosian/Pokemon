//
//  Navigatable.swift
//  PokemonTest
//
//  Created by 劉柏賢 on 2022/6/25.
//

protocol Navigatable: ParameterDelegate {
    associatedtype NavigationParameterType
    var navigationParameter: NavigationParameterType! { get set }
}

extension Navigatable {
    func getParameter() -> Any? {
        return navigationParameter
    }
    
    func setParameter(_ value: Any?) {
        navigationParameter = value as AnyObject as? NavigationParameterType
    }
}
