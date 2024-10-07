//
//  SignInInteractor.swift
//  RecipeApp
//
//  Created by Yasin Özdemir on 19.09.2024.
//

import Foundation
protocol SignInPresenterToInteractorProtocol {
    func signIn(mail: String, password: String,  completion: @escaping (Result<String, Error>) -> Void)
    func fetchUserInfos(id : String ,  completion: @escaping (Result<User, Error>) -> Void)
}
class SignInInteractor : SignInPresenterToInteractorProtocol {
    let authManager : IAuthManager = AuthManager()
    let fireStoreManager : IFirebaseManager = FirebaseManager()
    func signIn(mail: String, password: String,  completion: @escaping (Result<String, Error>) -> Void){
        authManager.signIn(mail: mail, password: password) { result in
            completion(result)
        }
       
    }
    func fetchUserInfos(id : String ,  completion: @escaping (Result<User, Error>) -> Void){
        fireStoreManager.fetchUserFromDatabase(with: id) { result in
            completion(result)
        }
    }
}
