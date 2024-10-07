//
//  DetailInteractor.swift
//  RecipeApp
//
//  Created by Yasin Özdemir on 2.10.2024.
//

import Foundation
protocol DetailPresenterToInteractorProtocol {
    func fetchRecipes(with id : String) async -> Result<Recipe , Error>
}
class DetailInteractor : DetailPresenterToInteractorProtocol {
    private let networkManager : INetworkManager = NetworkManager()
    func fetchRecipes(with id : String) async -> Result<Recipe , Error> {
       let result = await networkManager.download(url: NetworkConstants.searchWithIdUrl.rawValue + id, model: Recipe.self, httpMethod: .get)
        switch result {
        case .success(let recipe):
            return .success(recipe)
        case .failure(let error):
            return.failure(error)
        }
    }
}
