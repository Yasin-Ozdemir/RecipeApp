//
//  CategoryPresenter.swift
//  RecipeApp
//
//  Created by Yasin Özdemir on 13.10.2024.
//  
//

import Foundation

final class CategoryPresenter: ViewToPresenterCategoryProtocol {

    // MARK: Properties
    private let view: PresenterToViewCategoryProtocol
    private let interactor: PresenterToInteractorCategoryProtocol
    private let router: PresenterToRouterCategoryProtocol


    init(interactor: PresenterToInteractorCategoryProtocol, router: PresenterToRouterCategoryProtocol, view: PresenterToViewCategoryProtocol) {
        self.interactor = interactor
        self.router = router
        self.view = view
    }
    
    private var categoryList : [CategoryElement] = []
    
    func getCategory(for indexPath : IndexPath) -> CategoryElement {
        categoryList[indexPath.item]
    }
    func numberOfItemsInSection() -> Int {
        self.categoryList.count
    }
    
    func viewDidLoad() {
        downloadCategories()
    }
    func downloadCategories() {
        Task {
         let result =  await interactor.fetchCategories()
            switch result {
            case .success(let categories):
                guard let categories = categories else {
                    self.view.showAlert(title: "ERROR!", message: "Something went wrong. Please try again")
                    return
                }
                DispatchQueue.main.async {
                    self.categoryList = categories
                    self.view.reloadCollectionView()
                }
            case .failure(let error):
                self.view.showAlert(title: "ERROR!", message: error.localizedDescription)
            }
        }
        
    }
    
    func didSelectItem(At indexPath: IndexPath) {
        let url = NetworkConstants.categoryDetailUrl.rawValue + (self.categoryList[indexPath.item].strCategory ?? "")
        let title = self.categoryList[indexPath.item].strCategory ?? "Unkown"
        Task {
            let result = await interactor.fetchRecipes(url: url)
            switch result {
            case .success(let recipe):
                DispatchQueue.main.async {
                    self.goDetailVC(with: recipe, title: title)
                }


            case .failure(let failure):
                self.view.showAlert(title: "ERROR!", message: failure.localizedDescription)
            }
        }
    }
    func goDetailVC(with recipe : Recipe , title : String){
        view.goDetailVC(with: recipe , title : title)
    }
}

extension CategoryPresenter: InteractorToPresenterCategoryProtocol {
    
}
