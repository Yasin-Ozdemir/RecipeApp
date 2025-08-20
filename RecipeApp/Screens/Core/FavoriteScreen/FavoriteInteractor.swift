//
//  FavoriteInteractor.swift
//  RecipeApp
//
//  Created by Yasin Özdemir on 12.09.2024.
//

import Foundation

protocol FavoritePresenterToInteractorProtocol: AnyObject{
    func fetchRecipeDetails(id : String) async -> Result<Recipe , Error>
    func fetchFavorites( completion : @escaping (Result<Recipe , Error>) -> Void)
    func removeRecipeFromFavorites(id : String , completion : @escaping (Result<Void , Error>) -> Void)
}
final class FavoriteInteractor :FavoritePresenterToInteractorProtocol{
    private let networkManager : INetworkManager = NetworkManager()
    private let firestoreManager : FireStoreProtocol & FireStoreSearchProtocol = RecipeFirestoreManager()
    
    func fetchRecipeDetails(id : String) async -> Result<Recipe , Error> {
     let result = await networkManager.download(url: NetworkConstants.searchWithIdUrl.rawValue + id, model: Recipe.self, httpMethod: .get)
        return result
    }
    
    
    func fetchFavorites( completion : @escaping (Result<Recipe , Error>) -> Void) {
        firestoreManager.fetchFromDB(collectionPath: CurrentUser.user.id, documentId: "") { result in
            switch result {
                
            case .success(let meals) :
                guard let meals = meals as? [[String : String]] else{
                    completion(.failure(FireStoreError.dataError))
                    return
                }
                completion(.success(Recipe(meals: meals)))
                
            case .failure(let error) :
                completion(.failure(error))
            }
        }
    }
    
    func removeRecipeFromFavorites(id : String , completion : @escaping (Result<Void , Error>) -> Void){
        firestoreManager.deleteFromdB(collectionPath: CurrentUser.user.id, documentId: id) { result in
            completion(result )
        }
    }
}
