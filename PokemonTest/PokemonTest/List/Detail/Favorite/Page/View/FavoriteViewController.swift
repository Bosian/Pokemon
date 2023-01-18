//
//  FavoriteViewController.swift
//  PokemonTest
//
//  Created by 劉柏賢 on 2022/6/27.
//

import UIKit
import NSObject_Rx

final class FavoriteViewController: UIViewController, Viewer {

    @IBOutlet weak var tableView: UITableView!

    typealias ViewModelType = FavoriteViewModel
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

        let cellNib = UINib(nibName: "\(ListCell.self)", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "\(ListCellViewModel.self)")

        viewModel = ViewModelType()
    }
}

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource
{
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
        
        let storyboard = UIStoryboard(name: "DetailStoryboard", bundle: Bundle.main)
        guard let viewController = storyboard.instantiateInitialViewController() as? (UIViewController & ParameterDelegate) else {
            assert(false)
            return
        }

        let navigationParameter = DetailNavigationParameter(model: viewModel.cellViewModels.value[indexPath.row].model)
        viewController.setParameter(navigationParameter)
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
