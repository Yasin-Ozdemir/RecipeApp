//
//  TitleLabel.swift
//  RecipeApp
//
//  Created by Yasin Özdemir on 12.09.2024.
//

import UIKit

class TitleLabel: UILabel {

   
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    convenience init(align : NSTextAlignment , size : CGFloat ) {
       self.init(frame: .zero)
        self.textAlignment = align
        self.font = UIFont.systemFont(ofSize: size, weight: .bold)
    }
   private func configure(){
       textColor = .label
       numberOfLines = 1
       adjustsFontSizeToFitWidth = true
       minimumScaleFactor = 0.9
      
       translatesAutoresizingMaskIntoConstraints = false
    }
}
