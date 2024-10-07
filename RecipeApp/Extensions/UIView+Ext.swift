//
//  UIView+Ext.swift
//  RecipeApp
//
//  Created by Yasin Özdemir on 12.09.2024.
//

import Foundation
import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
   
}
