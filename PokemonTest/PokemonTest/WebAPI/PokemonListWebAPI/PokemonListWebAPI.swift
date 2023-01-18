//
//  PokemonListWebAPI.swift
//  PokemonTest
//
//  Created by 劉柏賢 on 2022/6/25.
//

import Foundation

/// List
struct PokemonListWebAPI: HTTPGet {

    typealias Parameter = PokemonListParameter
    typealias Model = PokemonListModel
    
    let urlString: String = "https://pokeapi.co/api/v2/pokemon"
    
    func invokeAsync(_ parameter: PokemonListParameter) async throws -> PokemonListModel {

        var urlComponent = URLComponents(string: urlString)
        urlComponent?.queryItems = [
            URLQueryItem(name: "offset", value: "\(parameter.offset)"),
            URLQueryItem(name: "limit", value: "\(parameter.limit)")
        ]

        return try await get(parameter, urlComponent?.url)
    }
}
