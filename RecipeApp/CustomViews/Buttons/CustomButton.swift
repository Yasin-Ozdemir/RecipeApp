//
//  CustomButton.swift
//  RecipeApp
//
//  Created by Yasin Özdemir on 14.09.2024.
//

import UIKit

final class CustomButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    convenience init(backgroundColor : UIColor , title : String , titleColor : UIColor) {
       self.init(frame: .zero)
       configuration?.baseBackgroundColor = backgroundColor
       configuration?.baseForegroundColor = titleColor
       configuration?.title = title
    }
    func configure(){
        configuration = .filled()
        configuration?.cornerStyle = .medium
    }

}
