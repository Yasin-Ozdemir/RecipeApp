//
//  User.swift
//  RecipeApp
//
//  Created by Yasin Özdemir on 4.10.2024.
//

import Foundation
struct User {
    let name : String
    let id : String
    let mail : String
    let password : String
    init(name: String, id: String, mail: String, password: String) {
        self.name = name
        self.id = id
        self.mail = mail
        self.password = password
    }
}
