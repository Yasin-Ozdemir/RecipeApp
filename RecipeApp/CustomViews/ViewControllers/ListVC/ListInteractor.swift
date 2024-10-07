//
//  ListInteractor.swift
//  RecipeApp
//
//  Created by Yasin Özdemir on 14.09.2024.
//

import Foundation
protocol ListPresenterToInteractorProtocol {
    func fetchCategories() async -> (Result<[CategoryElement]? , Error>)
    func fetchRecipes(url : String) async -> Result<Recipe , Error> 
}

class ListInteractor : ListPresenterToInteractorProtocol {
    let manager = NetworkManager()
    func fetchCategories() async -> (Result<[CategoryElement]? , Error>){
        
        let result =  await manager.download(url: NetworkConstants.categoriesUrl.rawValue
                                      , model: Category.self, httpMethod: .get)
            switch result {
            case .success(let category) :
                return .success(category.categories)
            case .failure(let error) :
                return .failure(error)
            }
        
    }
    
    func fetchRecipes(url : String) async -> Result<Recipe , Error> {
       let result = await manager.download(url: url, model: Recipe.self, httpMethod: .get)
        
        switch result {
        case .success(let recipe):
            return .success(recipe)
        case .failure(let error):
            return .failure(error)
        }
    }
}
