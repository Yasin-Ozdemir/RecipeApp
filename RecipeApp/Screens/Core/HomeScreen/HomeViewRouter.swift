//
//  HomeViewRouter.swift
//  RecipeApp
//
//  Created by Yasin Özdemir on 12.09.2024.
//

import Foundation
import UIKit
protocol HomePresenterToRouterProtocol {
    var viewControllerDelegate : UIViewController? {get set}
    
    static func generateModule() -> UIViewController
    func navigateDetailVC(with recipe : Recipe , title : String) 
}
class HomeRouter : HomePresenterToRouterProtocol{
    weak var viewControllerDelegate : UIViewController?
    
    
    static func generateModule() -> UIViewController{
        let viewController = HomeViewController()
        let router : HomePresenterToRouterProtocol = HomeRouter()
        let presenter : HomeViewToPresenterProtocol = HomePresenter()
        
        viewController.presenter = presenter
        viewController.presenter.router = router
        viewController.presenter.viewControllerDelegate = viewController
        
        viewController.presenter.router.viewControllerDelegate = viewController
        
        return viewController
    }
    func navigateDetailVC(with recipe : Recipe , title : String) {
        DispatchQueue.main.async {
            guard let vc = DetailRouter.generateModule() as? DetailViewController else{
                return
            }
            vc.presenter.recipes = recipe.meals!
            vc.title = title
            self.viewControllerDelegate?.navigationController?.navigate(to: vc)
        }
       
    }
}
