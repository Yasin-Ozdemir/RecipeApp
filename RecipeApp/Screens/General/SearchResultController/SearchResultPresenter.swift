//
//  SearchResultPresenter.swift
//  RecipeApp
//
//  Created by Yasin Özdemir on 15.09.2024.
//

import Foundation
protocol SearchViewControllerToPresenterProtocol {
    var interactor : SearchPresenterToInteractorProtocol! {get set}
    var viewDelegate : SearchPresenterToViewControllerProtocol! {get set}
    var router : SearchPresenterToRouterProtocol! {get set}
    
    func search(with name : String)
    func numberOfItemsInSection() -> Int
    func getRecipesList() -> [[String : String?]]
    func goRecipeDetailVC(for indexPath : IndexPath)
}
class SearchResultPresenter : SearchViewControllerToPresenterProtocol {
   
    var interactor : SearchPresenterToInteractorProtocol!
    weak var viewDelegate : SearchPresenterToViewControllerProtocol!
    var router : SearchPresenterToRouterProtocol!
    
    var recipes : [[String : String?]] = []
    func search(with name: String) {
        Task{
          let result =  await interactor.search(with: name)
            switch result {
            case .success(let recipe):
                guard let recipes = recipe.meals else {
                    self.recipes.removeAll()
                    self.viewDelegate.updateCollectionView()
                    return
                }
                
                DispatchQueue.main.async {
                    self.recipes = recipes
                    self.viewDelegate.updateCollectionView()
                }
                
            case .failure(let failure):
                self.viewDelegate.showError(message: failure.localizedDescription)
            }
          
        }
        
       
    }
    
    func numberOfItemsInSection() -> Int{
        return recipes.count
    }
    func getRecipesList() -> [[String : String?]] {
        return recipes
    }
    func goRecipeDetailVC(for indexPath : IndexPath){
        router.navigateRecipeDetailVC(recipe: self.recipes[indexPath.item])
    }
}
