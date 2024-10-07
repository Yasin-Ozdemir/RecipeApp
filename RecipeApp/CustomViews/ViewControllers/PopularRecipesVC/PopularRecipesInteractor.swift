//
//  PopularRecipesInteractor.swift
//  RecipeApp
//
//  Created by Yasin Özdemir on 14.09.2024.
//

import Foundation

protocol PopularRecipesPresenterToInteractorProtocol {
    func fetchRandomRecipe(url : String) async -> (Result<Recipe , Error>)
}

class PopularRecipesInteractor : PopularRecipesPresenterToInteractorProtocol {
    private let networkManager = NetworkManager()
    
    
    func fetchRandomRecipe(url : String) async -> (Result<Recipe , Error>){
      let result = await  networkManager.download(url: url, model: Recipe.self, httpMethod: .get)
        
        switch result {
        case .success(let recipe):
            return .success(recipe)
        case .failure(let error):
            return .failure(error)
        }
    }
}
