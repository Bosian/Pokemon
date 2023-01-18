//
//  UIViewControllerExtension.swift
//  PokemonTest
//
//  Created by 劉柏賢 on 2022/6/25.
//

import UIKit

extension UIViewController {
    func handlePrepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.destination {
        case let parameterDelegate as ParameterDelegate:
            parameterDelegate.setParameter(sender)
            
        case let destination as UINavigationController:
            
            if let parameterDelegate: ParameterDelegate = destination.viewControllers.first as? ParameterDelegate {
                parameterDelegate.setParameter(sender)
            }
            
        default:
            break
        }
    }

}
