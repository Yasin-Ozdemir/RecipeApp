//
//  RecipeDetailRouter.swift
//  RecipeApp
//
//  Created by Yasin Özdemir on 19.09.2024.
//

import Foundation
import UIKit
protocol RecipeDetailPresenterToRouterProtocol {
    var viewDelegate : UIViewController? {get set}
}
class RecipeDetailRouter : RecipeDetailPresenterToRouterProtocol {
    weak var viewDelegate: UIViewController?
    
    static func generateModule() -> UIViewController{
        let viewController = RecipeDetailViewController()
        let presenter : RecipeDetailViewToPresenterProtocol = RecipeDetailPresenter()
        let interactor : RecipeDetailPresenterToInteractorProtocol = RecipeDetailInteractor()
        let router : RecipeDetailPresenterToRouterProtocol = RecipeDetailRouter()
        
        viewController.presenter = presenter
        
        viewController.presenter.interactor = interactor
        viewController.presenter.router = router
        viewController.presenter.viewDelegate = viewController
        
        viewController.presenter.router.viewDelegate = viewController
        
        return viewController
    }
}
