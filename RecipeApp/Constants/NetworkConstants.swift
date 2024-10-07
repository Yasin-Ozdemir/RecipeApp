//
//  NetworkConstants.swift
//  RecipeApp
//
//  Created by Yasin Özdemir on 15.09.2024.
//

import Foundation

enum NetworkConstants : String {
    case randomRecipeUrl = "https://www.themealdb.com/api/json/v1/1/random.php"
    case categoriesUrl = "https://www.themealdb.com/api/json/v1/1/categories.php"
    case searchUrl = "https://www.themealdb.com/api/json/v1/1/search.php?s="
    case categoryDetailUrl = "https://www.themealdb.com/api/json/v1/1/filter.php?c="
    case areaDetailUrl = "https://www.themealdb.com/api/json/v1/1/filter.php?a="
    case searchWithIdUrl = "https://www.themealdb.com/api/json/v1/1/lookup.php?i="
    case youtubeBaseUrl = "https://www.youtube.com/embed/"
}
