//
//  RecipeDetailPresenter.swift
//  RecipeApp
//
//  Created by Yasin Özdemir on 19.09.2024.
//

import Foundation
protocol RecipeDetailViewToPresenterProtocol {
    var viewDelegate: RecipeDetailPresenterToViewProtocol? { get set }
    var interactor: RecipeDetailPresenterToInteractorProtocol! { get set }
    var router: RecipeDetailPresenterToRouterProtocol! { get set }
    var recipe: [String: String?] { get set }
    var isFavorite: Bool { get set }

    func getInstructionLenght() -> Int
    func addFavorite()
    func isFavoriteControl() -> Bool
    func viewDidLoad()
    func removeFavorite()

}
final class RecipeDetailPresenter: RecipeDetailViewToPresenterProtocol {
    weak var viewDelegate: RecipeDetailPresenterToViewProtocol?
    var interactor: RecipeDetailPresenterToInteractorProtocol!
    var router: RecipeDetailPresenterToRouterProtocol!
    init(viewDelegate: RecipeDetailPresenterToViewProtocol? = nil, interactor: RecipeDetailPresenterToInteractorProtocol!, router: RecipeDetailPresenterToRouterProtocol!, recipe: [String: String?]) {
        self.viewDelegate = viewDelegate
        self.interactor = interactor
        self.router = router
        self.recipe = recipe
    }
    var recipe = [String: String?]()

    var isFavorite: Bool = false
    func getInstructionLenght() -> Int {
        guard let instruction = recipe["strInstructions"] as? String else {
            return 0
        }

        return instruction.count
    }
    func viewDidLoad() {
        self.favoriteControl()
    }
    func addFavorite() {
        guard let id = recipe["idMeal"] as? String, let name = recipe["strMeal"] as? String, let imageUrl = recipe["strMealThumb"] as? String else {
            self.viewDelegate?.showAlert(title: "ERROR", message: "Something Went Wrong")
            return
        }

        interactor.addFavorite(id: id, name: name, imageUrl: imageUrl) { result in
            switch result {

            case .success(_):

                self.updateFavorite(with: true)
                self.viewDelegate?.showAlert(title: "Success", message: "Recipe has added favorites")
                NotificationCenter.default.post(name: NSNotification.Name("new favorite has added"), object: nil)



            case .failure(let error):
                self.viewDelegate?.showAlert(title: "ERROR", message: error.localizedDescription)
            }
        }


    }
    func removeFavorite() {
        guard let id = recipe["idMeal"] as? String else {
            self.viewDelegate?.showAlert(title: "ERROR", message: "Something Went Wrong")
            return
        }
        interactor.removeFavorite(id: id) { result in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    self.updateFavorite(with: false)
                    self.viewDelegate?.showAlert(title: "Removed", message: "Recipe has removed favorites")
                    NotificationCenter.default.post(name: NSNotification.Name("favorite has removed"), object: nil)
                }

            case .failure(let failure):
                self.viewDelegate?.showAlert(title: "ERROR", message: failure.localizedDescription)
            }
        }
    }
    private func favoriteControl() {
        guard let id = recipe["idMeal"] as? String else {
            return
        }
        interactor.controlFavorite(id: id) { result in
            switch result {
            case .success(_):
                self.updateFavorite(with: true)
            case .failure(_):
                self.isFavorite = false
            }
        }
    }
    func isFavoriteControl() -> Bool {
        self.isFavorite
    }
    func updateFavorite(with isBool: Bool) {
        self.isFavorite = isBool
        self.viewDelegate?.updateFavoriteButton()
    }
}
