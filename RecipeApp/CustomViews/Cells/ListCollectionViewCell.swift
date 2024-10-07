//
//  ListCollectionViewCell.swift
//  RecipeApp
//
//  Created by Yasin Özdemir on 13.09.2024.
//

import UIKit
import SnapKit
class ListCollectionViewCell: UICollectionViewCell {
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
    func setForCategoryAndArea(listType : ListType? = nil , model : (area : Area? , category : CategoryElement?) ){
        switch listType {
        
        case .categories:
            if model.category?.strCategory == "Breakfast" {
                self.imageView.image = UIImage(resource: .breakfast)
            } else if model.category?.strCategory == "Goat" {
                self.imageView.image = UIImage(resource: .goat)
            }else {
                self.imageView.downloadImage(url: model.category?.strCategoryThumb)
            }
            self.titleLabel.text = model.category?.strCategory ?? "Unkown"
            break
        
        
        case .areas:
            self.imageView.contentMode = .scaleToFill
            self.imageView.image = UIImage(named: model.area!.imageName)
            self.titleLabel.text = model.area?.name ?? "Unkown"
            break
        case .none: break
            
        }
        
    }
    func setForSearchResult(recipe : [String: String?]){
        guard let url = recipe["strMealThumb"] as? String , let title = recipe["strMeal"] as? String else{
            self.titleLabel.text = "Unkown"
            self.imageView.downloadImage(url: "")
            return
        }
        
        self.titleLabel.text = title
        self.imageView.downloadImage(url: url)
        
        
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
