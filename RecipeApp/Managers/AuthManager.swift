//
//  AuthManager.swift
//  RecipeApp
//
//  Created by Yasin Özdemir on 3.10.2024.
//

import Foundation
import FirebaseAuth
enum AuthError : Error{
    case signOutError
    case signOnError
    case signInError
}
protocol IAuthManager {
    func signIn(mail : String , password : String , completion : @escaping (Result<String , Error>) -> Void)
    func signOn(mail : String , password : String ,name : String, completion : @escaping (Result<User , Error>) -> Void)
    func signOut(completion : @escaping (Result<Void , Error>) -> Void)
}
class AuthManager : IAuthManager{
    let auth = Auth.auth()
    func signIn(mail : String , password : String , completion : @escaping (Result<String , Error>) -> Void){
        auth.signIn(withEmail: mail, password: password) { authResult, error in
            if let error = error {
                
                completion(.failure(error))
            }else{
                guard let authResult = authResult else{
                    completion(.failure(AuthError.signInError))
                    return
                }
                completion(.success(authResult.user.uid))
            }
            
        }
    }
    
    func signOn(mail : String , password : String ,name : String, completion : @escaping (Result<User , Error>) -> Void){
        auth.createUser(withEmail: mail, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
            }else{
                guard let authResult =  authResult  else{
                    completion(.failure(AuthError.signOnError))
                    return
                }
                let user = User(name: name, id: authResult.user.uid, mail: mail, password: password)
                completion(.success(user))
            }
            
        }
       
    }
    
    func signOut(completion : @escaping (Result<Void , Error>) -> Void){
        do {
            try auth.signOut()
            completion(.success(()))
        }catch {
            completion(.failure(AuthError.signOutError))
        }

        
    }
}
