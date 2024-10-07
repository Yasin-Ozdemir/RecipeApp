//
//  PopularRecipesPresenter.swift
//  RecipeApp
//
//  Created by Yasin Özdemir on 14.09.2024.
//

import Foundation

protocol PopularRecipesViewControllerToPresenterProtocol{
    var viewDelegate : PopularRecipesPresenterToViewControllerProtocol? {get set}
    var interactor : PopularRecipesPresenterToInteractorProtocol! {get set}
    var router : PopularRecipesPresenterToRouterProtocol! {get set}
    
    func viewDidLoad()
    func getPopularRecipes() -> [Recipe]
    func numberOfItemsInSection() -> Int
    func goRecipeDetailVC(for indexPath : IndexPath)
}
class PopularRecipesPresenter : PopularRecipesViewControllerToPresenterProtocol{
    weak var viewDelegate:  PopularRecipesPresenterToViewControllerProtocol?
    var interactor:  PopularRecipesPresenterToInteractorProtocol!
    var router:  PopularRecipesPresenterToRouterProtocol!
    
    private var recipeList : [Recipe] = []
    
    
    func viewDidLoad(){
        downloadPopularRecipes()
    }
    
    
    func getPopularRecipes() -> [Recipe] {
        return recipeList
    }
    
    
    func numberOfItemsInSection() -> Int {
        return recipeList.count
    }
    
    
    func downloadPopularRecipes(){
        viewDelegate?.showIndicator()
        Task {
            for i in 1...6{
                let result = await interactor.fetchRandomRecipe(url: NetworkConstants.randomRecipeUrl.rawValue)
                switch result {
                case .success(let recipe):
                    DispatchQueue.main.async {
                        self.recipeList.append(recipe)
                        self.viewDelegate?.reloadCollectionView()
                        self.viewDelegate?.dismissIndicator()
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.viewDelegate?.dismissIndicator()
                        self.viewDelegate?.showError()
                    }
                }
            }
        }
        
    }
    
    func goRecipeDetailVC(for indexPath : IndexPath){
        router.navigateRecipeDetailVC(recipe: self.recipeList[indexPath.item].meals![0])
    }
    
}
    
