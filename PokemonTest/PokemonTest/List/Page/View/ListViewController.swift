//
//  ListViewController.swift
//  PokemonTest
//
//  Created by 劉柏賢 on 2022/6/27.
//

import UIKit
import NSObject_Rx

final class ListViewController: UIViewController, Viewer {

    @IBOutlet weak var tableView: UITableView!

    typealias ViewModelType = ListViewModel
    var viewModel: ViewModelType! {
        didSet {
            viewModel.cellViewModels
                .asDriver()
                .drive { [weak self] _ in
                    self?.tableView.reloadData()
                }
                .disposed(by: rx.disposeBag)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = ViewModelType()

        let nib = UINib(nibName: "\(ListCell.self)", bundle: Bundle.main)
        tableView.register(nib, forCellReuseIdentifier: "\(ListCellViewModel.self)")
        
        FavoriteManager.shared.favorites
            .asDriver()
            .drive { [weak self] _ in
                self?.tableView.reloadData()
            }
            .disposed(by: rx.disposeBag)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        handlePrepare(for: segue, sender: sender)
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cellViewModels.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellViewModel = viewModel.cellViewModels.value[indexPath.row]
        let id: String = "\(type(of: cellViewModel))"
        let cell: (UITableViewCell & DataContextProtocol) = tableView.dequeueReusableCell(withIdentifier: id, for: indexPath) as! (UITableViewCell & DataContextProtocol)
        cell.dataContext = cellViewModel
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let navigationParameter = DetailNavigationParameter(model: viewModel.cellViewModels.value[indexPath.row].model)
        performSegue(withIdentifier: "\(DetailViewController.self)", sender: navigationParameter)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        guard indexPath.row > viewModel.cellViewModels.value.count - 2 else {
            return
        }

        Task {
            try await viewModel.loadMoreIfNeeded()
        }
    }
}
