//
//  AreaPresenter.swift
//  RecipeApp
//
//  Created by Yasin Özdemir on 13.10.2024.
//
//

import Foundation

final class AreaPresenter: ViewToPresenterAreaProtocol {

    // MARK: Properties
    private let view: PresenterToViewAreaProtocol
    private let interactor: PresenterToInteractorAreaProtocol
    private let router: PresenterToRouterAreaProtocol


    init(interactor: PresenterToInteractorAreaProtocol, router: PresenterToRouterAreaProtocol, view: PresenterToViewAreaProtocol) {
        self.interactor = interactor
        self.router = router
        self.view = view
    }

    private let areaList = [Area(name: "Turkish", imageName: "turkeyFlag"), Area(name: "British", imageName: "ukflag"), Area(name: "French", imageName: "frenchflag"), Area(name: "Russian", imageName: "russianFlag"), Area(name: "Indian", imageName: "indiaflag"), Area(name: "Egyptian", imageName: "egyptianflag"), Area(name: "American", imageName: "americanflag"), Area(name: "Mexican", imageName: "mexicanflag"), Area(name: "Italian", imageName: "italyflag"), Area(name: "Chinese", imageName: "chineseflag"), Area(name: "Japanese", imageName: "JapanFlag")]

    func getArea(for indexPath : IndexPath) -> Area {
        return areaList[indexPath.item]
    }
    
    func numberOfItemsInSection() -> Int {
        self.areaList.count
    }

    func didSelectItem(At indexPath: IndexPath) {
        let url = NetworkConstants.areaDetailUrl.rawValue + self.areaList[indexPath.item].name
        let title = self.areaList[indexPath.item].name
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

extension AreaPresenter: InteractorToPresenterAreaProtocol {

}
