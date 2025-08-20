//
//  SignInInteractor.swift
//  RecipeApp
//
//  Created by Yasin Özdemir on 19.09.2024.
//

import Foundation
protocol SignInPresenterToInteractorProtocol {
    func signIn(mail: String, password: String, completion: @escaping (Result<String, Error>) -> Void)
    func fetchUserInfos(id: String, completion: @escaping (Result<User, Error>) -> Void)
}
final class SignInInteractor: SignInPresenterToInteractorProtocol {
    private let authManager: IAuthManager = AuthManager()
    private let fireStoreManager: FireStoreProtocol = UserFirestoreManager()
    func signIn(mail: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
        authManager.signIn(mail: mail, password: password) { result in
            completion(result)
        }

    }
    func fetchUserInfos(id: String, completion: @escaping (Result<User, Error>) -> Void) {
        fireStoreManager.fetchFromDB(collectionPath: "Users", documentId: id) { result in
            switch result {

            case .success(let user):

                guard let name = user[0]["name"] as? String, let id = user[0]["id"] as? String, let mail = user[0]["mail"] as? String, let password = user[0]["password"] as? String else {
                    completion (.failure(FireStoreError.dataError))
                    return
                }
                let user = User(name: name, id: id, mail: mail, password: password)
                completion(.success(user))


            case .failure(let error):
                completion(.failure(error))

            }


        }

    }
}
