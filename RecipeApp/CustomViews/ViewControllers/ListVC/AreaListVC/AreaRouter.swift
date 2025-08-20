//
//  TestVbRouter.swift
//  PodcastApp
//
//  Created by vb10 on 1.02.2024.
//
//

import Foundation
import UIKit

final class  AreaRouter: PresenterToRouterAreaProtocol {
    // MARK: Static methods
    var view : UIViewController
    init(view: UIViewController) {
        self.view = view
    }
    static func createModule() -> UIViewController {
        let viewController = AreaViewController()
        let interactor = AreaInteractor()
        let router = AreaRouter(view: viewController)

        let presenter: ViewToPresenterAreaProtocol & InteractorToPresenterAreaProtocol = AreaPresenter(
            interactor: interactor, router: router, view: viewController)

        viewController.presenter = presenter
        interactor.presenter = presenter

        return viewController
    }
    

   
}
