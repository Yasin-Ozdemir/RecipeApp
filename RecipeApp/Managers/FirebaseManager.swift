//
//  FirebaseManager.swift
//  RecipeApp
//
//  Created by Yasin Özdemir on 3.10.2024.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth


enum FireStoreError: Error {
    case snapShotError
    case dataError
    case didntFindError
}


protocol FireStoreProtocol {
    func addToDB(collectionPath: String, documentId: String, data: [String: Any], completion: @escaping (Result<Void , Error>) -> Void)
    func fetchFromDB(collectionPath: String, documentId: String?, completion: @escaping (Result<[[String : Any]] , Error>) -> Void)
    func deleteFromdB(collectionPath: String, documentId: String, completion: @escaping (Result<Void , Error>) -> Void)
}


protocol FireStoreSearchProtocol {
    func searchInDB(collectionPath: String, key: String, value: String, completion: @escaping (Result<Void , Error>) -> Void)
}


 class FireStoreManager: FireStoreProtocol {
    
    internal let database = Firestore.firestore()
    func addToDB(collectionPath: String, documentId: String, data: [String: Any], completion: @escaping (Result<Void, any Error>) -> Void) {
        database.collection(collectionPath).document(documentId).setData(data)
        completion(.success(()))
    }

    func fetchFromDB(collectionPath: String, documentId: String?, completion: @escaping (Result<[[String : Any]], any Error>) -> Void) {
        
       /* if let documentId = documentId {
            self.fetchSingleDocument(collectionPath: collectionPath, documentId: documentId) { result in
                completion(result)
            }
        }
        
        self.fetchMultipleDocuments(collectionPath: collectionPath) { result in
            completion(result)
        }*/

    }
    
   

    func deleteFromdB(collectionPath: String, documentId: String, completion: @escaping (Result<Void, any Error>) -> Void) {
        database.collection(collectionPath).document(documentId).delete { err in
            guard let err = err else {
                completion (.success(()))
                return
            }

            completion (.failure(err))
        }
    }

}


class UserFirestoreManager: FireStoreManager {
    
    override func fetchFromDB(collectionPath: String, documentId: String?, completion: @escaping (Result<[[String : Any]], any Error>) -> Void) {
        guard let documentId = documentId else {
            return
        }

        database.collection(collectionPath).document(documentId).getDocument { documentSnapShot, error in
            if let error = error {
                completion(.failure(error))
            } else {
                guard let userData = documentSnapShot?.data() else {
                    completion(.failure(FireStoreError.dataError))
                    return
                }

                completion(.success([userData]))
            }
        }
    }

}

class RecipeFirestoreManager: FireStoreManager, FireStoreSearchProtocol {
    
    func searchInDB(collectionPath: String, key: String, value: String, completion: @escaping (Result<Void, any Error>) -> Void) {
        self.database.collection(collectionPath).whereField(key, isEqualTo: value).getDocuments { snapShot, error in
            if let error = error {
                completion(.failure(error))
            }
            guard let snapShot = snapShot else {
                completion(.failure(FireStoreError.dataError))
                return
            }
            for document in snapShot.documents {
                let data = document.data()

                guard data[key] is String else {
                    completion(.failure(FireStoreError.dataError))
                    return
                }
                completion(.success(()))

            }
        }
    }

    override func fetchFromDB(collectionPath: String, documentId: String?, completion: @escaping (Result<[[String : Any]], any Error>) -> Void) {
        database.collection(collectionPath).getDocuments { snapShot, error in
            guard let snapshot = snapShot else {
                completion(.failure(FireStoreError.snapShotError))
                return
            }
            if let error = error {
                completion(.failure(error))
            }
            var dataArray: [[String: Any]] = []


            for document in snapshot.documents {
                let data = document.data()
                dataArray.append(data)
            }

            completion(.success(dataArray))

        }
    }
}



