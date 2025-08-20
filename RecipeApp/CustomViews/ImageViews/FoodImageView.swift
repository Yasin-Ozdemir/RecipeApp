//
//  FoodImageView.swift
//  RecipeApp
//
//  Created by Yasin Özdemir on 12.09.2024.
//

import UIKit
import SDWebImage
final class FoodImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        clipsToBounds = true
        layer.cornerRadius = 15
        contentMode = .scaleAspectFit
    }
    
    func downloadImage(imagePath : String?){
        guard let imagePath = imagePath else {
            self.image = UIImage(resource: .placeholder)
            return
        }
        
        guard let url = URL(string: imagePath) else {
            self.image = UIImage(named: imagePath)
            return
        }
        sd_setImage(with: url)
    }
}

