//
//  PopularRecipesCollectionViewCell.swift
//  RecipeApp
//
//  Created by Yasin Özdemir on 12.09.2024.
//

import UIKit
import SnapKit
final class PopularRecipesCollectionViewCell: UICollectionViewCell {
    private let imageView = FoodImageView(frame: .zero)
    private let nameLabel = TitleLabel(align: .left, size: 15)
    private let categoryLabel = BodyLabel(align: .left, size: 14, color: .secondaryLabel)
    private let areaLabel = BodyLabel(align: .left, size: 14, color: .secondaryLabel)

    static let cellID = "PopularCell"
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        layer.cornerRadius = 15
        backgroundColor = .secondarySystemBackground
    }


    private func setupUI() {

        addSubview(areaLabel)
        addSubview(categoryLabel)
        addSubview(nameLabel)
        addSubview(imageView)
        areaLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-2)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview()
            make.height.equalTo(18)
        }
        categoryLabel.snp.makeConstraints { make in
            make.bottom.equalTo(areaLabel.snp.top).offset(-2)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview()
            make.height.equalTo(18)
        }
        nameLabel.snp.makeConstraints { make in
            make.bottom.equalTo(categoryLabel.snp.top).offset(-2)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview()
            make.height.equalTo(19)
        }
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(nameLabel.snp.top).offset(-5)
        }

    }

    public func set(meal: [String: String?]?) {
        guard let meal = meal else {
            return
        }
        let area = meal["strArea"] ?? "Unkown"
        let category = meal["strCategory"] ?? "Unkown"
        self.areaLabel.text = "Area: " + area!
        self.categoryLabel.text = "Category: " + category!
        self.nameLabel.text = meal["strMeal"] ?? "Unkown"
        self.imageView.downloadImage(imagePath: meal["strMealThumb"] ?? "")

    }
}

