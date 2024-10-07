//
//  FavoritePresenter.swift
//  RecipeApp
//
//  Created by Yasin Özdemir on 12.09.2024.
//

import Foundation

protocol FavoriteViewControllerToPresenterProtocol : AnyObject{
    var viewControllerDelegate : FavoritePresenterToViewControllerProtocol? {get set}
    var router : FavoritePresenterToRouterProtocol! {get set}
    var interactor : FavoritePresenterToInteractorProtocol! {get set}
    
    func numberOfRowsInSection() -> Int
    func getRecipe(for indexPath : IndexPath) -> [String : String?]?
    func didSelectRow(At indexPath : IndexPath)
    func viewDidLoad()
    func deleteRecipe(at indexPath : IndexPath)
}
class FavoritePresenter : FavoriteViewControllerToPresenterProtocol{
    weak var viewControllerDelegate : FavoritePresenterToViewControllerProtocol?
    var router : FavoritePresenterToRouterProtocol!
    var interactor : FavoritePresenterToInteractorProtocol!
    
    var recipe : Recipe?
    
    func viewDidLoad(){
        self.getFavorites()
        NotificationCenter.default.addObserver(self, selector: #selector(updateUI), name: NSNotification.Name("new favorite has added"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateUI), name: NSNotification.Name("favorite has removed"), object: nil)
    }
    func numberOfRowsInSection() -> Int{
        guard let meals = recipe?.meals else {
            return 0
        }
       return meals.count
    }
    

    func didSelectRow(At indexPath : IndexPath){
        guard let id = recipe!.meals![indexPath.row]["idMeal"] as? String else {
            return
        }
        Task {
          let result =  await   getRecipeDetails(with: id)
            switch result {
            case .success(let recipeDetail):
                DispatchQueue.main.async {
                    self.goRecipeDetailVC(recipe: recipeDetail.meals?[0])
                }
                
            case .failure(let error):
                DispatchQueue.main.async {
                    self.viewControllerDelegate?.showAlert(title: "ERROR", message: error.localizedDescription)
                }
                
            }
        }
        
    }
    
    func deleteRecipe(at indexPath : IndexPath){
        guard let id = recipe!.meals![indexPath.row]["idMeal"] as? String else {
            return
        }
        interactor.removeRecipeFromFavorites(id: id) { result in
            switch result {
            case .success(_):
                self.viewControllerDelegate?.showAlert(title: "", message: "Recipe Removed From Favorites")
                self.recipe?.meals?.remove(at: indexPath.row)
                self.viewControllerDelegate?.deleteRow(indexPath: indexPath)
                self.viewControllerDelegate?.reloadTableView()
            case .failure(let error):
                self.viewControllerDelegate?.showAlert(title: "ERROR", message: "Recipe Couldn't Delete")
            }
        }
    }
    
    
    private func getRecipeDetails(with id : String) async -> Result<Recipe , Error> {
      let result =  await interactor.fetchRecipeDetails(id: id)
        return result
    }
    
    
    private func goRecipeDetailVC(recipe : [String : String?]?){
        guard let recipe = recipe else {
            return
        }
        router.navigateRecipeDetailVC(recipe: recipe)
    }
    
    
    func getRecipe(for indexPath : IndexPath) -> [String : String?]?{
        return recipe?.meals?[indexPath.row]
    }
    
    
   private func getFavorites(){
        interactor.fetchFavorites { result in
            switch result {
            case .success(let recipe):
                self.recipe = recipe
                self.viewControllerDelegate?.reloadTableView()
            case .failure(let error):
                self.viewControllerDelegate?.showAlert(title: "ERROR", message: error.localizedDescription)
            }
        }
    }
    
    @objc private  func updateUI(){
        self.getFavorites()
    }
}
