//
//  SearchResultRouter.swift
//  RecipeApp
//
//  Created by Yasin Özdemir on 17.09.2024.
//

import Foundation
import UIKit
protocol SearchPresenterToRouterProtocol {
    var viewDelegate : UIViewController? {get set}
    
    func navigateRecipeDetailVC(recipe : [String : String?])
}
final class SearchResultRouter :SearchPresenterToRouterProtocol {
    weak var viewDelegate : UIViewController?
    
    static func generateModule() -> UIViewController{
        let viewController = SearchResultViewController()
        let presenter : SearchViewControllerToPresenterProtocol = SearchResultPresenter()
        let interactor : SearchPresenterToInteractorProtocol = SearchResultInteractor()
        let router : SearchPresenterToRouterProtocol = SearchResultRouter()
        
        viewController.presenter = presenter
        
        viewController.presenter.interactor = interactor
        viewController.presenter.router = router
        viewController.presenter.viewDelegate = viewController
        
        viewController.presenter.router.viewDelegate = viewController
        
        return viewController
    }
    
    func navigateRecipeDetailVC(recipe : [String : String?]){
        DispatchQueue.main.async {
            guard let detailVC = RecipeDetailRouter.generateModule(with: recipe) as? RecipeDetailViewController else {
                return
            }
           
            detailVC.modalPresentationStyle = .overFullScreen
            let nav = UINavigationController(rootViewController: detailVC)
            nav.modalPresentationStyle = .fullScreen
            self.viewDelegate?.present(nav, animated: true)
        }
      
    }
}
