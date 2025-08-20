//
//  SignTextField.swift
//  RecipeApp
//
//  Created by Yasin Özdemir on 3.10.2024.
//

import UIKit

final class SignTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    convenience init(placeHolder : String , hideText : Bool) {
       self.init(frame: .zero)
       self.placeholder = placeHolder
        self.isSecureTextEntry = hideText
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   private func configure(){
       self.backgroundColor = .tertiarySystemBackground
       self.textAlignment = .left
       self.layer.cornerRadius = 8
       self.layer.borderColor = ColorConstants.mainColor.cgColor
       self.layer.borderWidth = 0.5
    }

}
