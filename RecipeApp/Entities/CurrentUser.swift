//
//  CurrentUser.swift
//  RecipeApp
//
//  Created by Yasin Özdemir on 3.10.2024.
//

import Foundation

struct CurrentUser{
    var mail : String = ""
    var password : String = ""
    var name : String = ""
    var id = ""
   
    private init() {
        
    }
    static var user = CurrentUser()
}
