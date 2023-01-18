//
//  WebAPIProtocols.swift
//  PokemonTest
//
//  Created by 劉柏賢 on 2022/6/27.
//

import Foundation

protocol WebAPIProtocols {

    associatedtype Parameter
    associatedtype Model: Decodable
    
    var urlString: String { get }
    
    @MainActor
    func invokeAsync (_ parameter: Parameter) async throws -> Model
}
