//
//  SignOnInteractor.swift
//  RecipeApp
//
//  Created by Yasin Özdemir on 19.09.2024.
//

import Foundation
protocol SignOnPresenterToInteractorProtocol {
    func signOn(mail: String, password: String, name : String,  completion: @escaping (Result<User, Error>) -> Void)
    func registerUser(user : User ,  completion: @escaping (Result<Void, Error>) -> Void)
}
class SignOnInteractor : SignOnPresenterToInteractorProtocol {
    private let authManager : IAuthManager = AuthManager()
    private let fireStoreManager : IFirebaseManager = FirebaseManager()
    func signOn(mail: String, password: String, name : String,  completion: @escaping (Result<User, Error>) -> Void){
        authManager.signOn(mail: mail, password: password, name: name) { result in
            completion(result)
        }
    }
    
    func registerUser(user : User ,  completion: @escaping (Result<Void, Error>) -> Void){
        fireStoreManager.saveUserToDatabase(user: user) { result in
           completion(result)
        }
    }
}
