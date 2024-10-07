//
//  FavoriteInteractor.swift
//  RecipeApp
//
//  Created by Yasin Özdemir on 12.09.2024.
//

import Foundation

protocol FavoritePresenterToInteractorProtocol: AnyObject{
    func fetchRecipeDetails(id : String) async -> Result<Recipe , Error>
    func fetchFavorites( completion : @escaping (Result<Recipe? , Error>) -> Void)
    func removeRecipeFromFavorites(id : String , completion : @escaping (Result<Void , Error>) -> Void)
}
class FavoriteInteractor :FavoritePresenterToInteractorProtocol{
    private let networkManager : INetworkManager = NetworkManager()
    private let firestoreManager : IFirebaseManager = FirebaseManager()
    
    func fetchRecipeDetails(id : String) async -> Result<Recipe , Error> {
     let result = await networkManager.download(url: NetworkConstants.searchWithIdUrl.rawValue + id, model: Recipe.self, httpMethod: .get)
        return result
    }
    
    
    func fetchFavorites( completion : @escaping (Result<Recipe? , Error>) -> Void) {
        firestoreManager.fetchRecipesFromDB { result in
            completion(result)
        }
    }
    
    func removeRecipeFromFavorites(id : String , completion : @escaping (Result<Void , Error>) -> Void){
        firestoreManager.deleteRecipeFromDB(with: id) { result in
            completion(result)
        }
    }
}
