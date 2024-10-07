//
//  BodyLabel.swift
//  RecipeApp
//
//  Created by Yasin Özdemir on 12.09.2024.
//

import UIKit

class BodyLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    convenience init(align : NSTextAlignment , size : CGFloat , color : UIColor) {
       self.init(frame: .zero)
        self.textColor = color
        self.textAlignment = align
        self.font = UIFont.systemFont(ofSize: size, weight: .regular)
        
    }
   private func configure(){
      numberOfLines = 3
       lineBreakMode = .byWordWrapping
       translatesAutoresizingMaskIntoConstraints = false
    }

}
