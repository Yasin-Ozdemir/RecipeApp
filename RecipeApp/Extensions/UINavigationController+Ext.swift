//
//  UINavigationController+Ext.swift
//  RecipeApp
//
//  Created by Yasin Özdemir on 29.09.2024.
//

import Foundation
import UIKit

extension UINavigationController {
    func navigate(to viewController: UIViewController){
        let trans = CATransition()
        trans.duration = 0.3
        trans.type = .moveIn
        trans.subtype = CATransitionSubtype.fromRight
        trans.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
        view.window?.layer.add(trans, forKey: kCATransition)
        pushViewController(viewController, animated: false)
    }

}
