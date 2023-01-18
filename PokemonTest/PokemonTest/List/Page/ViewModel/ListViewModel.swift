//
//  ListViewModel.swift
//  PokemonTest
//
//  Created by 劉柏賢 on 2022/6/27.
//

import Foundation
import RxCocoa

final class ListViewModel {
    let cellViewModels: BehaviorRelay<[ListCellViewModel]> = BehaviorRelay<[ListCellViewModel]>(value: [])

    private var model: [PokemonListModel.Result] = []

    private var isUpdate: Bool = false
    private var isDataLoaded: Bool = false
    private let limit: Int = 10
    
    init() {
        refresh()
    }
    
    private func refresh() {
        
        isDataLoaded = false
        
        self.model.removeAll()
        
        Task {
            try await loadMore(limit: limit, offset: 0)
            self.isDataLoaded = true
        }
    }
    
    func loadMoreIfNeeded() async throws {
        
        guard isDataLoaded else {
            return
        }
        
        guard !isUpdate else {
            return
        }
        
        let offset: Int = self.model.count
        
        print("count: \(limit)")
        print("after: \(offset)")

        try await loadMore(limit: limit, offset: offset)
    }

    private func loadMore(limit: Int, offset: Int) async throws {
        
        isUpdate = true
        
        let parameter = PokemonListParameter(limit: limit, offset: offset)
        let model = try await callPokemonListWebAPI(parameter: parameter)
        
        isUpdate = false
        
        self.model.append(contentsOf: model.results)
        
        updateCell(model: model)
    }
    
    private func updateCell(model: PokemonListModel) {
        var cellViewModels = self.cellViewModels.value
        let news = model.results.map { model in
            return ListCellViewModel(model: model)
        }
        cellViewModels.append(contentsOf: news)
        self.cellViewModels.accept(cellViewModels)
    }
    
    private func callPokemonListWebAPI(parameter: PokemonListParameter) async throws -> PokemonListModel {
        return try await PokemonListWebAPI().invokeAsync(parameter)
    }
}
