//
//  PokemonDetailWebAPI.swift
//  PokemonTest
//
//  Created by 劉柏賢 on 2022/6/25.
//

import Foundation

/// List
struct PokemonDetailWebAPI: HTTPGet {

    typealias Parameter = PokemonDetailParameter
    typealias Model = PokemonDetailModel
    
    let urlString: String
    
    func invokeAsync(_ parameter: PokemonDetailParameter) async throws -> PokemonDetailModel {

        var urlComponent = URLComponents(string: urlString)
        urlComponent?.queryItems = [

        ]

        return try await get(parameter, urlComponent?.url)
    }
}
