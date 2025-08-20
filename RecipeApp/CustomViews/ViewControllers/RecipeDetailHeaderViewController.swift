//
//  RecipeDetailHeaderViewController.swift
//  RecipeApp
//
//  Created by Yasin Özdemir on 20.09.2024.
//

import UIKit
import SnapKit
final class RecipeDetailHeaderViewController: UIViewController {
    private let recipeImageView = FoodImageView(frame: .zero)
    private let nameLabel = TitleLabel(align: .center, size: 19)
    private let categoryLabel = TitleLabel(align: .center, size: 17)
    private let areaLabel = TitleLabel(align: .center, size: 17)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
        setupUILayouts()
    }
    
    init(recipe : [String: String?]) {
        super.init(nibName: nil, bundle: nil)
        self.set(recipe: recipe)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupVC(){
        self.view.backgroundColor = .secondarySystemBackground
        self.view.layer.cornerRadius = 10
       
        self.recipeImageView.contentMode = .scaleToFill
        self.view.addSubviews(recipeImageView,nameLabel,categoryLabel,areaLabel)
    }
    private func setupUILayouts(){
        let padding = 8
        self.recipeImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(padding)
            make.centerY.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.8)
            make.width.equalTo(recipeImageView.snp.height)
        }
        self.nameLabel.snp.makeConstraints { make in
            
            make.leading.equalTo(recipeImageView.snp.trailing)
            make.trailing.equalToSuperview().inset(padding)
            make.top.equalToSuperview().offset(padding*3)
            make.height.equalTo(21)
        }
       
       
        self.categoryLabel.snp.makeConstraints { make in
            make.leading.equalTo(recipeImageView.snp.trailing)
            make.trailing.equalToSuperview().inset(padding)
            make.top.equalTo(nameLabel.snp.bottom).offset(padding*5)
            make.height.equalTo(19)
        }
        self.areaLabel.snp.makeConstraints { make in
            make.leading.equalTo(recipeImageView.snp.trailing)
            make.trailing.equalToSuperview().inset(padding)
            make.top.equalTo(categoryLabel.snp.bottom).offset(padding*5)
            make.height.equalTo(19)
        }
    }
    private func set(recipe : [String: String?]){
        guard let url = recipe["strMealThumb"] as? String, let name = recipe["strMeal"] as? String, let area = recipe["strArea"] as? String, let category = recipe["strCategory"] as? String else {
            self.recipeImageView.downloadImage(imagePath: "" )
            self.nameLabel.text = "Unkown"
            self.areaLabel.text = "Unkown"
            self.categoryLabel.text = "Unkown"
            return
        }
        self.recipeImageView.downloadImage(imagePath: url )
        self.nameLabel.text = name
        self.areaLabel.text = "Area:  " + area
        self.categoryLabel.text = "Category:  " + category
    }
    
}

