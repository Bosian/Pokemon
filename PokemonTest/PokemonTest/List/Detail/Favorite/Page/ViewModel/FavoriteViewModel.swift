//
//  FavoriteViewModel.swift
//  PokemonTest
//
//  Created by 劉柏賢 on 2022/6/27.
//

import Foundation
import RxSwift
import RxCocoa

final class FavoriteViewModel {

    let cellViewModels: BehaviorRelay<[ListCellViewModel]> = BehaviorRelay<[ListCellViewModel]>(value: [])
    private var disposeBag: DisposeBag = DisposeBag()
    
    init() {
        refresh()
    }
    
    private func refresh() {

        disposeBag = DisposeBag()

        FavoriteManager.shared.favorites
            .asDriver()
            .drive { [weak self] (models: [FavoriteModel]) in
                self?.updateCell(models: models)
            }
            .disposed(by: disposeBag)
    }
    
    private func updateCell(models: [FavoriteModel]) {

		let models = models.sorted(by: >)

		let rows: [ListCellViewModel] = models.map { (item: FavoriteModel) in
			return ListCellViewModel(favoriteModel: item)
		}

        self.cellViewModels.accept(rows)
    }
}
