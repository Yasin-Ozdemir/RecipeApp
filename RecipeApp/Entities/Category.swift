//
//  Category.swift
//  RecipeApp
//
//  Created by Yasin Özdemir on 13.09.2024.
//

import Foundation

struct Category: Codable {
    let categories: [CategoryElement]?
}

// MARK: - CategoryElement
struct CategoryElement: Codable {
    let idCategory, strCategory: String?
    let strCategoryThumb: String?
    let strCategoryDescription: String?
}
