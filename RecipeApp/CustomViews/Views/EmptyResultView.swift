//
//  EmptyVC.swift
//  RecipeApp
//
//  Created by Yasin Özdemir on 7.10.2024.
//

import Foundation
import UIKit
import SnapKit
final class EmptyResultView : UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .secondarySystemBackground
        label.text = "WE ARE SORRY :( \nRECIPE DID NOT FOUND!"
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let label = TitleLabel(align: .center, size: 25)
    
    func configureView(){
        label.numberOfLines = 2
        label.textColor = ColorConstants.mainColor
        addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(60)
            make.width.equalToSuperview().multipliedBy(0.9)
        }
    }
}
