//
//  NetworkManager.swift
//  RecipeApp
//
//  Created by Yasin Özdemir on 13.09.2024.
//
import Alamofire
import Foundation

protocol INetworkManager {
    func download<T: Codable>(url : String , model : T.Type , httpMethod : HTTPMethod) async -> (Result<T , Error>)
}
final class NetworkManager : INetworkManager{
        
    func download<T: Codable>(url : String , model : T.Type , httpMethod : HTTPMethod) async -> (Result<T , Error>){
       
        
        let response = await AF.request(url , method: httpMethod).validate().serializingDecodable(T.self).response
       
        switch response.result {
        case .success(let value) : return .success(value)
        case .failure(let error) : return .failure(error)
        }
    }
}
