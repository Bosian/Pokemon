//
//  FavoriteModel.swift
//  PokemonTest
//
//  Created by 劉柏賢 on 2022/6/30.
//

import Foundation
import RealmSwift

final class FavoriteModel: Object, Comparable {
    
    /// 加入時間，排序用
    @Persisted var updateTime: Double = 0.0

	/// e.g. "https://pokeapi.co/api/v2/pokemon/1/"
    @Persisted var url: String = ""
    
	/// e.g. "bulbasaur"
    @Persisted var name: String = ""
	
    var model: PokemonListModel.Result {
        return PokemonListModel.Result(name: name, url: url)
    }

    /// 沒override會crash
    override init() {
        super.init()
    }
    
    convenience init(model: PokemonListModel.Result) {
        self.init()
        
        self.updateTime = Date().timeIntervalSince1970

        self.url = model.url
        self.name = model.name
    }

    static func < (lhs: FavoriteModel, rhs: FavoriteModel) -> Bool {
        return lhs.updateTime < rhs.updateTime
    }
}
