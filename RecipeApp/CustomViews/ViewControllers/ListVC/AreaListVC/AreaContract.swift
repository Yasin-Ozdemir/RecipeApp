//
//  AreaContract.swift
//  RecipeApp
//
//  Created by Yasin Özdemir on 13.10.2024.
//  
//

import Foundation


// MARK: View Output (Presenter -> View)
protocol PresenterToViewAreaProtocol {
    func goDetailVC(with recipe : Recipe , title : String)
    func showAlert(title : String,message: String)
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterAreaProtocol {
    func getArea(for indexPath : IndexPath) -> Area
    func didSelectItem(At indexPath: IndexPath)
    func numberOfItemsInSection() -> Int
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorAreaProtocol {
    
    var presenter: InteractorToPresenterAreaProtocol? { get set }
    func fetchRecipes(url : String) async -> Result<Recipe , Error> 
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterAreaProtocol {
    
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterAreaProtocol {
    
}
