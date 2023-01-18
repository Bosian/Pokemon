//
//  FavoriteManager.swift
//  PokemonTest
//
//  Created by 劉柏賢 on 2022/6/29.
//

import Foundation
import RxSwift
import RxCocoa
import RealmSwift

final class FavoriteManager {
    
    static let shared: FavoriteManager = FavoriteManager()

    let favorites: BehaviorRelay<[FavoriteModel]> = BehaviorRelay<[FavoriteModel]>(value: [])

    // Open the local-only default realm
    private let realm = try! Realm()
    
    /// 避免 SwiftUI preview 無法將Item加入最愛
    private let userDefault: UserDefaults? = UserDefaults(suiteName: "group.PokemonTest")

    private let disposeBag: DisposeBag = DisposeBag()
    
    private init() {
        load()
    }
    
	func toggleFavorite(model: PokemonListModel.Result?) {

        guard let model = model else {
            return
        }

        if isFavorite(model: model) {
            
            // Remove
            var value = favorites.value
            
            guard let first = value.enumerated().first(where: { (index: Int, item: FavoriteModel) -> Bool in
				return item.name == model.name
            }) else {
                assertionFailure("刪除失敗：不存在")
                return
            }

            // Realm
            delete(model: first.element)
            value.remove(at: first.offset)
            
            favorites.accept(value)
            
        } else {
            // Add
            var value = favorites.value
            let favoriteModel = FavoriteModel(model: model)
            value.insert(favoriteModel, at: 0)

            // Realm
            add(model: favoriteModel)
            
            favorites.accept(value)
        }
    }
    
    func isFavorite(model: PokemonListModel.Result) -> Bool {
        return favorites.value.contains { (item: FavoriteModel) in
            return item.name == model.name
        }
    }
    
    private func add(model: FavoriteModel) {

        do {
            // Save to realm
            try realm.write {
                realm.add(model)
            }
        } catch {
            assert(false)
            print(String(describing: error))
        }
    }
    
    private func delete(model: FavoriteModel) {
        do {
            // Save to realm
            try realm.write {
                realm.delete(model)
            }
        } catch {
            assert(false)
            print(String(describing: error))
        }
    }
    
    private func load() {

        // Load from realm
        let obj: Results<FavoriteModel> = realm.objects(FavoriteModel.self)
        favorites.accept(Array(obj))
    }
}
