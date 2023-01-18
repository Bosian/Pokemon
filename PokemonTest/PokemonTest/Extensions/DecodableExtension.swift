//
//  DecodableExtension.swift
//  PokemonTest
//
//  Created by 劉柏賢 on 2022/6/25.
//

import Foundation

extension Decodable {

    init?(json: String) {

        guard let data = json.data(using: String.Encoding.utf8) else {
            return nil
        }

        let decoder = JSONDecoder()
        do {
            self = try decoder.decode(Self.self, from: data)
        } catch {
            print(error)
            return nil
        }
    }

    init(data: Data?) throws {
        guard let data = data else {
            throw NSError(domain: "data is nil", code: -1)
        }

        Self.debugPrint(data: data)
        
        let decoder = JSONDecoder()
        do {
            self = try decoder.decode(Self.self, from: data)
        } catch {
            print(error)
            throw error
        }
    }
    
#if DEBUG
    private static func debugPrint(data: Data) {
        do {
            let jsonDictionary = try JSONSerialization.jsonObject(with: data)
            let data = try JSONSerialization.data(withJSONObject: jsonDictionary, options: .prettyPrinted)
            let json = String(data: data, encoding: String.Encoding.utf8) ?? ""
            
            print(json)
        } catch {
            print(error)
        }
    }
#endif
}
