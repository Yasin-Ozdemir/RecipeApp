//
//  PopularRecipesRouter.swift
//  RecipeApp
//
//  Created by Yasin Özdemir on 14.09.2024.
//

import Foundation
import UIKit
protocol PopularRecipesPresenterToRouterProtocol{
    var viewDelegate : UIViewController? {get set}
    
    func navigateRecipeDetailVC(recipe : [String : String?])
}
final class PopularRecipesRouter : PopularRecipesPresenterToRouterProtocol{
    weak var viewDelegate: UIViewController?
    
    static func generateModule() -> UIViewController {
        let view = PopularRecipesVC()
       
        let presenter : PopularRecipesViewControllerToPresenterProtocol = PopularRecipesPresenter()
        let interactor : PopularRecipesPresenterToInteractorProtocol = PopularRecipesInteractor(networkManager: NetworkManager())
        let router : PopularRecipesPresenterToRouterProtocol = PopularRecipesRouter()
        
        view.presenter = presenter
        
        view.presenter.interactor = interactor
        view.presenter.router = router
        view.presenter.viewDelegate = view
        
        view.presenter.router.viewDelegate = view
        return view
    }
    
    func navigateRecipeDetailVC(recipe : [String : String?]){
        guard let detailVC = RecipeDetailRouter.generateModule(with: recipe) as? RecipeDetailViewController else {
            return
        }
        
        let nav = UINavigationController(rootViewController: detailVC)
        nav.modalPresentationStyle = .fullScreen
        viewDelegate?.present(nav, animated: true)
    }
}

