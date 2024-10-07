//
//  ProfileInteractor.swift
//  RecipeApp
//
//  Created by Yasin Özdemir on 12.09.2024.
//

import Foundation
protocol ProfilePresenterToInteractorProtocol : AnyObject{
    func signOut(completion : @escaping (Result<Void , Error>) -> Void)
}
class ProfileInteractor : ProfilePresenterToInteractorProtocol {
    let authManager : IAuthManager = AuthManager()
    func signOut(completion : @escaping (Result<Void , Error>) -> Void){
        authManager.signOut { result in
            completion(result)
        }
    }
}
