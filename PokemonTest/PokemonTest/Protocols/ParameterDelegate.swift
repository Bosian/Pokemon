//
//  ParameterDelegate.swift
//  PokemonTest
//
//  Created by 劉柏賢 on 2022/6/27.
//

import Foundation

protocol ParameterDelegate: AnyObject {
    func getParameter() -> Any?
    func setParameter(_ value: Any?)
}
