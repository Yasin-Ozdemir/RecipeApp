//
//  ListCollectionViewCell.swift
//  RecipeApp
//
//  Created by Yasin Özdemir on 13.09.2024.
//

import UIKit
import SnapKit

final class ListCollectionViewCell: UICollectionViewCell {
    static let cellID = "ListCollectionCell"
    
    private var categoryElement : CategoryElement?
    private var area : Area?
    
    private let titleLabel = TitleLabel(align: .center, size: 15)
    private let imageView = FoodImageView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        layer.cornerRadius = 15
        backgroundColor = .secondarySystemBackground
       
    }
    func set(title: String? , imagePath: String?) {
        self.titleLabel.text = title ?? "Unkown"
        self.imageView.downloadImage(imagePath: imagePath)
    }
    
    private func setupUI(){
        addSubviews(titleLabel , imageView)
        
        self.titleLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(14)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(17)
        }
        
        self.imageView.snp.makeConstraints { make in
            make.bottom.equalTo(titleLabel.snp.top)
            make.leading.equalToSuperview().offset(3)
            make.trailing.equalToSuperview().inset(3)
            make.top.equalToSuperview()
        }
    }
}
