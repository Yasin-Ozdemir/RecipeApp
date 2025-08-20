//
//  SizeConstants.swift
//  RecipeApp
//
//  Created by Yasin Özdemir on 30.09.2024.
//

import Foundation

struct SizeConstants {
    static var ingredientHeiht = 0
   
    static func getInsturcionHeight(textLenght : Int) -> Double {
        Double(textLenght) / 40 * 16.2  +  30
    }
    
    static func getRecipeDetailVcContentHeight(textLenght : Int) -> Double {
        let insturcionHeight = getInsturcionHeight(textLenght: textLenght)
        
        return insturcionHeight * 1.1 + Double(ingredientHeiht) * 1.1  + 630
    }
}
