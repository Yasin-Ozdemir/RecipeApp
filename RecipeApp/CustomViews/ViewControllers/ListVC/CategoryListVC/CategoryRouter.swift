//
//  TestVbRouter.swift
//  PodcastApp
//
//  Created by vb10 on 1.02.2024.
//
//

import Foundation
import UIKit

final class  CategoryRouter: PresenterToRouterCategoryProtocol {
    // MARK: Static methods
    var view : UIViewController
    init(view: UIViewController) {
        self.view = view
    }
    static func createModule() -> UIViewController {
        let viewController = CategoryViewController()
        let interactor = CategoryInteractor()
        let router = CategoryRouter(view: viewController)

        let presenter: ViewToPresenterCategoryProtocol & InteractorToPresenterCategoryProtocol = CategoryPresenter(
            interactor: interactor, router: router, view: viewController)

        viewController.presenter = presenter
        interactor.presenter = presenter

        return viewController
    }


    
}
