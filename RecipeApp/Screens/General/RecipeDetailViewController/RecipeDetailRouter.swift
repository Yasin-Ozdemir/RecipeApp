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
final class RecipeDetailRouter : RecipeDetailPresenterToRouterProtocol {
    weak var viewDelegate: UIViewController?
    
    static func generateModule(with recipe : [String : String?]) -> UIViewController{
        let interactor : RecipeDetailPresenterToInteractorProtocol = RecipeDetailInteractor()
        var router : RecipeDetailPresenterToRouterProtocol = RecipeDetailRouter()
        var presenter : RecipeDetailViewToPresenterProtocol = RecipeDetailPresenter(interactor: interactor, router: router, recipe: recipe)
        
        
        let viewController = RecipeDetailViewController(presenter: presenter)
        presenter.viewDelegate = viewController
        router.viewDelegate = viewController
   
        
        return viewController
    }
}
