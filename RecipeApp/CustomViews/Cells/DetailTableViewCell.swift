//
//  DetailTableViewCell.swift
//  RecipeApp
//
//  Created by Yasin Özdemir on 30.09.2024.
//

import UIKit
import SnapKit
final class RecipeTableViewCell: UITableViewCell {
    static let cellId = "recipeTableCell"
    private var mealImageView = FoodImageView(frame: .zero)
    private var titleLabel = TitleLabel(align: .left, size: 15)
    private var accessoryImage = UIImageView(image: UIImage(systemName: SFSymbols.chevron.rawValue))
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
  
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureCell(){
        self.layer.cornerRadius = 6
        self.backgroundColor = .secondarySystemBackground
        self.tintColor = ColorConstants.mainColor
        self.addSubviews(mealImageView , titleLabel ,accessoryImage )
        self.applyConstraints()
    }
    private func applyConstraints(){
        let padding = 10
        self.mealImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(padding)
            make.centerY.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.8)
            make.width.equalTo(mealImageView.snp.height)
        }
        self.accessoryImage.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(padding)
            make.centerY.equalToSuperview()
            make.height.equalTo(15)
            make.width.equalTo(15)
        }
        self.titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(mealImageView.snp.trailing).offset(padding*2)
            make.centerY.equalToSuperview()
            make.height.equalTo(20)
            make.trailing.equalTo(accessoryImage.snp.leading).inset(padding)
        }
        
    }
    public func set(recipe : [String : String?]?){
        guard let recipe = recipe , let url = recipe["strMealThumb"] as? String , let title = recipe["strMeal"] as? String else {
            mealImageView.downloadImage(imagePath: "")
            titleLabel.text = "Unkown"
            return
        }
        mealImageView.downloadImage(imagePath: url)
        titleLabel.text = title
        
    }
}
