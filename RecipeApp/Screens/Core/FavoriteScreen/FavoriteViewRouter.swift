//
//  FavoriteViewRouter.swift
//  RecipeApp
//
//  Created by Yasin Özdemir on 12.09.2024.
//

import Foundation
import UIKit
protocol FavoritePresenterToRouterProtocol : AnyObject{
    var viewControllerDelegate : UIViewController? { get set }
    
    static func generateModule() -> UIViewController
    func navigateRecipeDetailVC(recipe : [String : String?])
}
class FavoriteRouter : FavoritePresenterToRouterProtocol{
    weak var viewControllerDelegate : UIViewController?
    
    static func generateModule() -> UIViewController{
        let viewController = FavoriteViewController()
        let presenter : FavoriteViewControllerToPresenterProtocol = FavoritePresenter()
        let interactor : FavoritePresenterToInteractorProtocol = FavoriteInteractor()
        let router : FavoritePresenterToRouterProtocol = FavoriteRouter()
        
        viewController.presenter = presenter
        
        viewController.presenter.interactor = interactor
        viewController.presenter.router = router
        viewController.presenter.viewControllerDelegate = viewController
        
        viewController.presenter.router.viewControllerDelegate = viewController
        
        return viewController
    }
    
    func navigateRecipeDetailVC(recipe : [String : String?]){
        guard let vc = RecipeDetailRouter.generateModule() as? RecipeDetailViewController else{
            return
        }
        vc.presenter.recipe = recipe
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        self.viewControllerDelegate?.present(nav, animated: true)
    }
}
