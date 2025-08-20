//
//  IngredientItem.swift
//  RecipeApp
//
//  Created by Yasin Özdemir on 7.10.2024.
//

import Foundation
import UIKit
import SnapKit
final class IngredientItem: UIView {
    private var imageView = FoodImageView(frame: .zero)
    private var label = BodyLabel(align: .left, size: 14, color: .label)

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    convenience init(imageUrl: String, ingredientName: String) {
        self.init(frame: .zero)
        self.set(imageUrl: imageUrl, ingredientName: ingredientName)
    }
    private func configureView() {
        self.backgroundColor = .secondarySystemBackground
        self.addSubviews(imageView, label)
        applyConstraints()
    }
    private func applyConstraints() {
        imageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(imageView.snp.width)
        }

        label.snp.makeConstraints { make in
            make.leading.equalTo(imageView.snp.trailing)
            make.bottom.equalToSuperview().inset(2)
            make.top.equalToSuperview().offset(2)
        }
    }
    private func set(imageUrl: String?, ingredientName: String?) {
        self.imageView.downloadImage(imagePath: imageUrl)
        self.label.text = ingredientName ?? "Unkown"
    }
}
