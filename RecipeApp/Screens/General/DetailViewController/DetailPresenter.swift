//
//  DetailPresenter.swift
//  RecipeApp
//
//  Created by Yasin Özdemir on 2.10.2024.
//

import Foundation

protocol DetailViewToPresenterProtocol {
    var viewDelegate : DetailPresenterToViewProtocol? {get set}
    var interactor : DetailPresenterToInteractorProtocol! {get set}
    var router : DetailPresenterToRouterProtocol! {get set}
    
    var recipes : [[String : String?]] {get set}
    
    func numberOfRowsInSection()-> Int
    func didSelectItem(at indexPath : IndexPath)
    func getRecipe(at indexPath : IndexPath) -> [String : String?]
}
class DetailPresenter : DetailViewToPresenterProtocol {
    
    weak var viewDelegate : DetailPresenterToViewProtocol?
    var interactor : DetailPresenterToInteractorProtocol!
    var router : DetailPresenterToRouterProtocol!
    var recipes : [[String : String?]] = []
    private var meal : [String : String?]?
   
    func getRecipeDetails(with id : String) async{
        
         let result =   await interactor.fetchRecipes(with: id)
            switch result {
            case .success(let recipe):
                self.meal = recipe.meals?[0]
            case .failure(let error):
                viewDelegate?.showError(message: error.localizedDescription)
            }
        
    }
    
    func goRecipeDetailVC(){
        guard let meal = meal else {
            viewDelegate?.showError(message: "Recipe Not Found!")
            return
        }
        router.navigateRecipeDetailVC(recipe: meal)
    }
    func getRecipe(at indexPath : IndexPath) -> [String : String?] {
        recipes[indexPath.row]
    }
    func numberOfRowsInSection()-> Int{
        recipes.count
    }
    
    func didSelectItem(at indexPath : IndexPath) {
        guard let id = self.recipes[indexPath.row]["idMeal"] as? String else {
            return
        }
        Task {
           await getRecipeDetails(with: id)
            DispatchQueue.main.async {
                self.goRecipeDetailVC()
            }
            
        }
        
    }
}
