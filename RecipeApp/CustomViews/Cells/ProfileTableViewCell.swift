//
//  ProfileTableViewCell.swift
//  RecipeApp
//
//  Created by Yasin Özdemir on 19.09.2024.
//

import Foundation
import UIKit
import SnapKit
class ProfileTableViewCell : UITableViewCell {
    private let titleLabel = TitleLabel(align: .left, size: 17)
    
    private var container : UIView = {
       let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 20
    
        return view
    }()
    
    private var leadingImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = ColorConstants.mainColor
        return imageView
    }()
    private var trailingImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = ColorConstants.mainColor
        imageView.image = UIImage(systemName: SFSymbols.chevron.rawValue)
        return imageView
    }()
    static let cellID = "ProfileTable"
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configure(){
        layer.borderColor = ColorConstants.mainColor.cgColor
        backgroundColor = .systemBackground
        tintColor = ColorConstants.mainColor
        
    }
    private func setupUI(){
        addSubview(container)
        container.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.80)
            make.width.equalToSuperview()
        }
        container.addSubviews(leadingImageView , titleLabel , trailingImageView)
        
        leadingImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.centerY.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.45)
            make.width.equalTo(leadingImageView.snp.height)
        }
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(leadingImageView.snp.trailing).offset(15)
            make.centerY.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.5)
        }
        trailingImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(15)
            make.centerY.equalToSuperview()
            make.height.equalTo(15)
            make.width.equalTo(leadingImageView.snp.height)
        }
    }
    public func setItems(imagePath : SFSymbols , title : String){
        self.leadingImageView.image = UIImage(systemName: imagePath.rawValue)
        self.titleLabel.text = title
    }
}
