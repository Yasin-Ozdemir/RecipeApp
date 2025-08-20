//
//  ProfileRouter.swift
//  RecipeApp
//
//  Created by Yasin Özdemir on 12.09.2024.
//

import Foundation
import UIKit
protocol ProfilePresenterToRouterProtocol : AnyObject{
    var viewControllerDelegate : UIViewController? {get set}
    func navigateLogInVC()
}

final class ProfileRouter : ProfilePresenterToRouterProtocol{
    weak var viewControllerDelegate : UIViewController?
    
    static func generateModule() -> UIViewController {
        let viewController = ProfileViewController()
        let presenter : ProfileViewControllerToPresenterProtocol = ProfilePresenter()
        let interactor : ProfilePresenterToInteractorProtocol = ProfileInteractor()
        let router : ProfilePresenterToRouterProtocol = ProfileRouter()
        
        viewController.presenter = presenter
        
        viewController.presenter.viewControllerDelegate = viewController
        viewController.presenter.interactor = interactor
        viewController.presenter.router = router
        
        viewController.presenter.router.viewControllerDelegate = viewController
        
        return viewController
    }
    
    func navigateLogInVC(){
       
        if let sceneDelegate = self.viewControllerDelegate?.view.window?.windowScene?.delegate as? SceneDelegate {
                        sceneDelegate.checkAuthentication()
        }
        
    }
}
