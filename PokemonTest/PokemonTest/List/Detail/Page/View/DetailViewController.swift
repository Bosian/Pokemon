//
//  DetailViewController.swift
//  PokemonTest
//
//  Created by 劉柏賢 on 2022/6/27.
//

import UIKit
import NSObject_Rx
import Kingfisher

final class DetailViewController: UIViewController, Viewer, Navigatable {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var favoriteButton: UIButton!
    
    typealias ViewModelType = DetailViewModel
    var viewModel: ViewModelType! {
        didSet {
            viewModel.model
                .asDriver()
                .drive(onNext: { [weak self] (model: PokemonDetailModel?) in
                    self?.updateProfile(model: model)
                })
                .disposed(by: rx.disposeBag)
            
            viewModel.isUpdate
                .asDriver()
                .drive { [weak self] (isUpdate: Bool) in
                    self?.scrollView.isHidden = isUpdate
                    self?.activityIndicator.isHidden = !isUpdate
                }
                .disposed(by: rx.disposeBag)
        }
    }

    typealias NavigationParameterType = DetailNavigationParameter
    var navigationParameter: NavigationParameterType!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = ViewModelType(navigationParameter: navigationParameter)
        
        self.title = navigationParameter.model.name
        
        FavoriteManager.shared.favorites
            .asDriver()
            .drive { [weak self] _ in
                self?.updateFavoriteButton()
            }
            .disposed(by: rx.disposeBag)
    }
    
    private func updateFavoriteButton() {
        favoriteButton.setImage(viewModel.favoriteIcon, for: UIControl.State.normal)
    }

    private func updateProfile(model: PokemonDetailModel?) {
        
        guard let model = model else {
            return
        }
        
        icon.kf.setImage(with: URL(string: model.sprites.frontDefault))

        let text: String = {
            let names: [String] = model.types.map(\.type.name)
            let displayType: String = names.joined(separator: ", ")
            
            return """
            • 編號：\(model.id)
            • 身高：\(model.height)
            • 體重：\(model.weight)
            • 屬性：\(displayType)
            """
        }()
        
        titleLabel.text = text
    }

    @IBAction func onFavoriteTapped(_ sender: UIButton) {
        FavoriteManager.shared.toggleFavorite(model: viewModel.navigationParameter.model)
    }
}
