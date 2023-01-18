//
//  PokemonDetailModel.swift
//  PokemonTest
//
//  Created by 劉柏賢 on 2022/6/27.
//

import Foundation

struct PokemonDetailModel: Decodable {
		
    /// 編號
    let id: Int
    
    /// 圖片
    let sprites: Sprites
    
    /// 身高
    let height: Int
    
    /// 體重
    let weight: Int
    
    /// 屬性
    let types: [`Types`]
}

extension PokemonDetailModel {

    struct `Types`: Decodable {
        struct `Type`: Decodable {
            
            /// e.g. "bulbasaur"
            let name: String
            
            /// e.g. "https://pokeapi.co/api/v2/pokemon/1/"
            let url: String
        }

        let type: Type
    }

    struct Sprites: Decodable {
        enum CodingKeys: String, CodingKey {
            case frontDefault = "front_default"
        }

        let frontDefault: String
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.frontDefault = try container.decode(String.self, forKey: .frontDefault)
        }
    }
}

