//
//  CategoryContract.swift
//  RecipeApp
//
//  Created by Yasin Özdemir on 13.10.2024.
//  
//

import Foundation


// MARK: View Output (Presenter -> View)
protocol PresenterToViewCategoryProtocol {
    func showAlert(title : String , message : String)
    func goDetailVC(with recipe : Recipe , title : String)
    func reloadCollectionView()
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterCategoryProtocol {
    func numberOfItemsInSection() -> Int
    func getCategory(for indexPath : IndexPath) -> CategoryElement
    func didSelectItem(At indexPath: IndexPath)
    func viewDidLoad()
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorCategoryProtocol {
    func fetchCategories() async -> (Result<[CategoryElement]? , Error>)
    func fetchRecipes(url : String) async -> Result<Recipe , Error> 
    var presenter: InteractorToPresenterCategoryProtocol? { get set }
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterCategoryProtocol {
    
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterCategoryProtocol {
    
}
