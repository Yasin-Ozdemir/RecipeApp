//
//  SignInRouter.swift
//  RecipeApp
//
//  Created by Yasin Özdemir on 19.09.2024.
//

import Foundation
import UIKit

protocol SignInPresenterToRouterProtocol {
    var viewDelegate : UIViewController? {get set}
    func navigateHomeVC()
    func navigateSignOnVC()
}
final class SignInRouter : SignInPresenterToRouterProtocol {
    weak var viewDelegate: UIViewController?
    
    static func generateModule() -> UIViewController{
        let viewController = SignInViewController()
        let presenter : SignInViewToPresenterProtocol = SignInPresenter()
        let interactor : SignInPresenterToInteractorProtocol = SignInInteractor()
        let router : SignInPresenterToRouterProtocol = SignInRouter()
        
        viewController.presenter = presenter
        
        viewController.presenter.interactor = interactor
        viewController.presenter.router = router
        viewController.presenter.viewDelegate = viewController
        
        viewController.presenter.router.viewDelegate = viewController
        
        return viewController
    }
    
    func navigateHomeVC(){
       
        if let sceneDelegate = self.viewDelegate?.view.window?.windowScene?.delegate as? SceneDelegate {
                        sceneDelegate.checkAuthentication()
        }

    }
    
    func navigateSignOnVC() {
        let vc = SignOnRouter.generateModule()
        self.viewDelegate?.navigationController?.navigate(to: vc)
    }
    
      
}
