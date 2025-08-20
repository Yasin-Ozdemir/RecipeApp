//
//  AreaInteractor.swift
//  RecipeApp
//
//  Created by Yasin Özdemir on 13.10.2024.
//  
//

import Foundation

final class AreaInteractor: PresenterToInteractorAreaProtocol  {
    private let networkManager : INetworkManager = NetworkManager()
    // MARK: Properties
    var presenter: InteractorToPresenterAreaProtocol?
    
     func fetchRecipes(url : String) async -> Result<Recipe , Error> {
       let result = await networkManager.download(url: url, model: Recipe.self, httpMethod: .get)
        
        switch result {
        case .success(let recipe):
            return .success(recipe)
        case .failure(let error):
            return .failure(error)
        }
    }
}
