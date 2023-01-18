//
//  HTTPGet.swift
//  PokemonTest
//
//  Created by 劉柏賢 on 2022/6/28.
//

import Foundation

protocol HTTPGet: WebAPIProtocols {
    func get(_ parameter: Parameter) async throws -> Model
    func get(_ parameter: Parameter, _ url: URL?) async throws -> Model
}

extension HTTPGet {
    
    @MainActor
    func get(_ parameter: Parameter) async throws -> Model {
        return try await get(parameter, URL(string: urlString))
    }
    
    @MainActor
    func get(_ parameter: Parameter, _ url: URL?) async throws -> Model {

        guard let url = url else {
            throw NSError(domain: "url is nil", code: -1)
        }

        print("request url(\(type(of: self))): \(url.absoluteString)")
        let request = URLRequest(url: url)
        print("parameter: \(parameter)")

        do {
            print("response url(\(type(of: self))): \(url.absoluteString)")
            let (data, _) = try await URLSession.shared.data(for: request)
            return try Model(data: data)
        } catch {
            print(error)
            throw error
        }
    }
    
    func invokeAsync(_ parameter: Parameter) async throws -> Model {
        return try await get(parameter)
    }
}
