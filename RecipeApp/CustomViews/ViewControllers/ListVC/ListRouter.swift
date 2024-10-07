//
//  ListRouter.swift
//  RecipeApp
//
//  Created by Yasin Özdemir on 14.09.2024.
//

import Foundation
import UIKit
protocol ListPresenterToRouterProtocol{
    var viewDelegate : UIViewController? {get set}
}
class ListRouter : ListPresenterToRouterProtocol{
    weak var viewDelegate: UIViewController?
    
    static func generateModule(with type : ListType) -> UIViewController {
        let view = ListVC(type: type)
        let presenter : ListViewControllerToPresenterProtocol = ListPresenter()
        let interactor : ListPresenterToInteractorProtocol = ListInteractor()
        let router : ListPresenterToRouterProtocol = ListRouter()
        
        view.presenter = presenter
        
        view.presenter.interactor = interactor
        view.presenter.router = router
        view.presenter.viewDelegate = view
        
        view.presenter.router.viewDelegate = view
        return view
    }
    
    
}
