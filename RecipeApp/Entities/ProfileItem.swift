//
//  ProfileItem.swift
//  RecipeApp
//
//  Created by Yasin Özdemir on 19.09.2024.
//

import Foundation

struct ProfileItem {
    let imagePath : SFSymbols
    let title : String
    init(imagePath: SFSymbols, title: String) {
        self.imagePath = imagePath
        self.title = title
    }
}
