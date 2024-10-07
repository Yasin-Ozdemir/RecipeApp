//
//  RecipeDetailInteractor.swift
//  RecipeApp
//
//  Created by Yasin Özdemir on 19.09.2024.
//

import Foundation
protocol RecipeDetailPresenterToInteractorProtocol {
    func addFavorite(id : String , name : String , imageUrl : String)
    func controlFavorite(id : String , completion : @escaping (Result<Void , Error>) -> Void)
    func removeFavorite(id : String , completion : @escaping (Result<Void , Error>) -> Void)
}
class RecipeDetailInteractor : RecipeDetailPresenterToInteractorProtocol {
    private let firestoreManager : IFirebaseManager =  FirebaseManager()
    func addFavorite(id : String , name : String , imageUrl : String){
        firestoreManager.addRecipeToDB(id: id, imageUrl: imageUrl, name: name)
    }
    func controlFavorite(id : String , completion : @escaping (Result<Void , Error>) -> Void)  {
        firestoreManager.controlFavoriteInDB(id: id) { result in
            completion(result)
        }
    }
    func removeFavorite(id : String , completion : @escaping (Result<Void , Error>) -> Void){
        firestoreManager.deleteRecipeFromDB(with: id) { result in
            completion(result)
        }
    }
}
