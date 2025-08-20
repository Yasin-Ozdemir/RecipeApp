//
//  SignOnRouter.swift
//  RecipeApp
//
//  Created by Yasin Özdemir on 19.09.2024.
//

import Foundation
import UIKit
protocol SignOnPresenterToRouterProtocol {
    var viewDelegate : UIViewController? {get set}
    func navigateBack()
}
final class SignOnRouter : SignOnPresenterToRouterProtocol {
    weak var viewDelegate: UIViewController?
    
    static func generateModule() -> UIViewController{
        let viewController = SignOnViewController()
        let presenter : SignOnViewToPresenterProtocol = SignOnPresenter()
        let interactor : SignOnPresenterToInteractorProtocol = SignOnInteractor()
        let router : SignOnPresenterToRouterProtocol = SignOnRouter()
        
        viewController.presenter = presenter
        
        viewController.presenter.interactor = interactor
        viewController.presenter.router = router
        viewController.presenter.viewDelegate = viewController
        
        viewController.presenter.router.viewDelegate = viewController
        
        return viewController
    }
    
    func navigateBack(){
        DispatchQueue.main.async {
            self.viewDelegate?.navigationController?.popToRootViewController(animated: true)
        }
        
    }
}
