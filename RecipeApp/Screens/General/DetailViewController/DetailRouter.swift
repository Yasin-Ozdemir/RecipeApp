//
//  DetailRouter.swift
//  RecipeApp
//
//  Created by Yasin Özdemir on 2.10.2024.
//

import Foundation
import UIKit

protocol DetailPresenterToRouterProtocol {
    var viewDelegate: UIViewController? { get set }
    func navigateRecipeDetailVC(recipe: [String: String?])
}
final class DetailRouter: DetailPresenterToRouterProtocol {

    weak var viewDelegate: UIViewController?

    static func generateModule() -> UIViewController {
        let viewController = DetailViewController()
        let presenter: DetailViewToPresenterProtocol = DetailPresenter()
        let interactor: DetailPresenterToInteractorProtocol = DetailInteractor(networkManager: NetworkManager())
        let router: DetailPresenterToRouterProtocol = DetailRouter()

        viewController.presenter = presenter

        viewController.presenter.interactor = interactor
        viewController.presenter.router = router
        viewController.presenter.viewDelegate = viewController

        viewController.presenter.router.viewDelegate = viewController

        return viewController
    }
    func navigateRecipeDetailVC(recipe: [String: String?]) {
        DispatchQueue.main.async {
            guard let detailVC = RecipeDetailRouter.generateModule(with: recipe) as? RecipeDetailViewController else {
                return
            }
            let nav = UINavigationController(rootViewController: detailVC)
            nav.modalPresentationStyle = .fullScreen
            self.viewDelegate?.present(nav, animated: true)
        }

    }
}
