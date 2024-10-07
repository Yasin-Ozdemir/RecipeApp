//
//  ListPresenter.swift
//  RecipeApp
//
//  Created by Yasin Özdemir on 14.09.2024.
//

import Foundation
protocol ListViewControllerToPresenterProtocol {
    var viewDelegate : ListPresenterToViewControllerProtocol? {get set}
    var interactor : ListPresenterToInteractorProtocol! {get set}
    var router : ListPresenterToRouterProtocol! {get set}
    
    func viewDidLoad()
    func getCategoryList() -> [CategoryElement]
    func getAreaList() -> [Area]
    func didSelectItem(At indexPath : IndexPath , type : ListType)
}
class ListPresenter : ListViewControllerToPresenterProtocol {
    weak var viewDelegate:  ListPresenterToViewControllerProtocol?
    var interactor: ListPresenterToInteractorProtocol!
    var router: ListPresenterToRouterProtocol!
    
   private let areaList = [Area(name: "Turkish", imageName: "turkeyFlag"),Area(name: "British", imageName: "ukflag"),Area(name: "French", imageName: "frenchflag") ,Area(name: "Russian", imageName: "russianFlag"),Area(name: "Indian", imageName: "indiaflag"),Area(name: "Egyptian", imageName: "egyptianflag")  ,Area(name: "American", imageName: "americanflag") , Area(name: "Mexican", imageName: "mexicanflag"),Area(name: "Italian", imageName: "italyflag"), Area(name: "Chinese", imageName: "chineseflag") , Area(name: "Japanese", imageName: "JapanFlag")]
    private var categoryList : [CategoryElement] = []
    private var recipe : Recipe?
    func getAreaList() -> [Area] {
        return areaList
    }
    
    func getCategoryList() -> [CategoryElement] {
        return categoryList
    }
    func viewDidLoad(){
        downloadCategories()
    }
    func downloadCategories() {
        Task {
         let result =  await interactor.fetchCategories()
            switch result {
            case .success(let categories):
                guard let categories = categories else {
                    self.viewDelegate?.showError(message: "Something went wrong. Please try again")
                    return
                }
                DispatchQueue.main.async {
                    self.categoryList = categories
                    self.viewDelegate?.reloadCollectionView()
                }
            case .failure(let error):
                self.viewDelegate?.showError(message: error.localizedDescription)
            }
        }
        
    }
    
    func didSelectItem(At indexPath : IndexPath , type : ListType)  {
        Task{
            var url = ""
            var title = ""
            if type == .areas {
                url = NetworkConstants.areaDetailUrl.rawValue + self.areaList[indexPath.item].name
                title = self.areaList[indexPath.item].name
                
            }else {
                url = NetworkConstants.categoryDetailUrl.rawValue + self.categoryList[indexPath.item].strCategory!
                title = self.categoryList[indexPath.item].strCategory!
            }
             let result =  await interactor.fetchRecipes(url: url)
                switch result {
                case .success(let recipe):
                    DispatchQueue.main.async {
                        self.goDetailVC(with: recipe , title : title)
                    }
                    
                    
                case .failure(let failure):
                    self.viewDelegate?.showError(message: failure.localizedDescription)
                }
        }
     
    }
    
    func goDetailVC(with recipe : Recipe , title : String){
        viewDelegate?.goDetailVC(with: recipe , title : title)
    }
    
}
