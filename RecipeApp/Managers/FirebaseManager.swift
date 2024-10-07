//
//  FirebaseManager.swift
//  RecipeApp
//
//  Created by Yasin Özdemir on 3.10.2024.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
enum FireStoreError : Error {
    case snapShotError
    case dataError
    case didntFindError
}

protocol IFirebaseManager {
    func addRecipeToDB( id : String , imageUrl : String , name : String)
    func fetchRecipesFromDB(completion : @escaping (Result<Recipe? , Error>) -> Void)
    func deleteRecipeFromDB(with id : String , completion : @escaping (Result<Void , Error>) -> Void)
    func saveUserToDatabase(user : User,completion : @escaping (Result<Void , Error>) -> Void)
    func fetchUserFromDatabase(with id : String , completion : @escaping (Result<User , Error>) -> Void)
    func controlFavoriteInDB(id : String, completion : @escaping (Result<Void , Error>) -> Void)
}
class FirebaseManager :IFirebaseManager {
    private let database = Firestore.firestore()
    func addRecipeToDB( id : String , imageUrl : String , name : String){
        let json = [
            "idMeal"  :  id,
            "strMealThumb" : imageUrl,
            "strMeal" : name
        ]
        
        
        database.collection(CurrentUser.user.id).document(id)
            .setData(json)
    }
    
    func controlFavoriteInDB(id : String, completion : @escaping (Result<Void , Error>) -> Void){
        database.collection(CurrentUser.user.id).whereField("idMeal", isEqualTo: id).getDocuments { snapShot, error in
            if let error = error {
                completion(.failure(error))
            }
            guard let snapShot = snapShot else{
                completion(.failure(FireStoreError.dataError))
             return
            }
            for document in snapShot.documents {
                let data = document.data()
                
                guard let recipeId = data["idMeal"] as? String else{
                    completion(.failure(FireStoreError.dataError))
                    return
                }
                if id == recipeId {
                    completion(.success(()))
                }else{
                    completion(.failure(FireStoreError.didntFindError))
                }
            }
        }
    }
    
    func fetchRecipesFromDB(completion : @escaping (Result<Recipe? , Error>) -> Void){

        database.collection(CurrentUser.user.id).getDocuments { snapShot, error in
            guard let snapshot = snapShot else {
                completion(.failure(FireStoreError.snapShotError))
                return
            }
            if let error = error {
                completion(.failure(error))
            }
            var meals  : [[String : String]] = []
            for document in snapshot.documents {
                let data = document.data()
                
                guard let id = data["idMeal"] as? String , let imageUrl = data["strMealThumb"] as? String, let name = data["strMeal"]as? String else{
                    completion(.failure(FireStoreError.dataError))
                    return
                }
                meals.append(["strMeal": name , "idMeal" : id , "strMealThumb" : imageUrl])
                
            }
            let recipe = Recipe(meals: meals)
            completion(.success(recipe))
            
        }
            
    }
    
    
    func deleteRecipeFromDB(with id : String , completion : @escaping (Result<Void , Error>) -> Void){
        database.collection(CurrentUser.user.id).document(id).delete { error in
            if let error = error {
                completion(.failure(error))
            }
            
            completion(.success(()))
        }
    }
    
    func saveUserToDatabase(user : User,completion : @escaping (Result<Void , Error>) -> Void){
        let documentData : [String : String] = [
            "name" : user.name,
            "mail" : user.mail,
            "password" : user.password,
            "id" : user.id
        ]
        database.collection("Users").document(user.id).setData(documentData) { error in
            if let error = error {
                completion(.failure(error))
            }else{
                completion(.success(()))
            }
        }
    }
    
    func fetchUserFromDatabase(with id : String , completion : @escaping (Result<User , Error>) -> Void){
        database.collection("Users").document(id).getDocument { documentSnapShot, error in
            if let error = error {
                completion(.failure(error))
            }else{
                guard let userData = documentSnapShot?.data() else{
                    completion(.failure(FireStoreError.dataError))
                    return
                }
                guard let name = userData["name"] as? String, let mail = userData["mail"] as? String, let password = userData["password"] as? String else {
                    return
                }
                
                completion(.success(User(name: name, id: id, mail: mail, password: password)))
            }
           
            
        }
    }
}
