//
//  SearchResultInteractor.swift
//  RecipeApp
//
//  Created by Yasin Özdemir on 15.09.2024.
//

import Foundation
protocol SearchPresenterToInteractorProtocol {
    func search(with name : String) async -> (Result<Recipe,Error>)
}
class SearchResultInteractor  :SearchPresenterToInteractorProtocol{
    private let networkManager = NetworkManager()
    func search(with name: String) async -> (Result<Recipe,Error>){
      let result = await networkManager.download(url: NetworkConstants.searchUrl.rawValue + name, model: Recipe.self, httpMethod: .get)
        
        switch result {
        case .success(let recipe):
            return .success(recipe)
        case .failure(let err):
            return .failure(err)
        }
    }
    
    
}
