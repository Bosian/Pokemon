//
//  EncodableExtension.swift
//  PokemonTest
//
//  Created by 劉柏賢 on 2022/6/30.
//

import Foundation

extension Encodable {
    func toData() throws -> Data {
        let encoder = JSONEncoder()
        return try encoder.encode(self)
        
    }
}
