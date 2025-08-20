//
//  RecipeDetailInteractor.swift
//  RecipeApp
//
//  Created by Yasin Özdemir on 19.09.2024.
//

import Foundation
protocol RecipeDetailPresenterToInteractorProtocol {
    func addFavorite(id: String, name: String, imageUrl: String , completion : @escaping(Result<Void,Error>) -> Void)
    func controlFavorite(id: String, completion: @escaping (Result<Void , Error>) -> Void)
    func removeFavorite(id: String, completion: @escaping (Result<Void , Error>) -> Void)
}
final class RecipeDetailInteractor: RecipeDetailPresenterToInteractorProtocol {
    private let firestoreManager: FireStoreProtocol & FireStoreSearchProtocol = RecipeFirestoreManager()
    func addFavorite(id: String, name: String, imageUrl: String , completion : @escaping(Result<Void,Error>) -> Void) {
        
        let data = [
            "idMeal": id,
            "strMeal": name,
            "strMealThumb": imageUrl
        ]
        
        firestoreManager.addToDB(collectionPath: CurrentUser.user.id,
                                 documentId: id,
                                 data: data) { result in
            completion(result)
        }
    }
    func controlFavorite(id: String, completion: @escaping (Result<Void , Error>) -> Void) {
        firestoreManager.searchInDB(collectionPath: CurrentUser.user.id, key: "idMeal", value: id) { result in
            completion(result)
        }
    }
    func removeFavorite(id: String, completion: @escaping (Result<Void , Error>) -> Void) {
        firestoreManager.deleteFromdB(collectionPath: CurrentUser.user.id, documentId: id) { result in
            completion(result)
        }
    }
}
