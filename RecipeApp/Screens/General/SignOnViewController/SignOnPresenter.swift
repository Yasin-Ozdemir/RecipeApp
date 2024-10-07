//
//  SignOnPresenter.swift
//  RecipeApp
//
//  Created by Yasin Özdemir on 19.09.2024.
//

import Foundation
protocol SignOnViewToPresenterProtocol {
    var viewDelegate : SignOnPresenterToViewProtocol? {get set}
    var interactor : SignOnPresenterToInteractorProtocol! {get set}
    var router : SignOnPresenterToRouterProtocol! {get set}
    
    func registerUser(mail : String , password : String, name: String)
}
class SignOnPresenter : SignOnViewToPresenterProtocol {
    weak var viewDelegate: SignOnPresenterToViewProtocol?
    var interactor:  SignOnPresenterToInteractorProtocol!
    var router: SignOnPresenterToRouterProtocol!
    
    func registerUser(mail : String , password : String, name: String){
        interactor.signOn(mail: mail, password: password, name: name) { result in
            switch result {
            case .success(let user):
                self.interactor.registerUser(user: user) { result in
                    switch result {
                    case .success(_):
                        self.viewDelegate?.showAlert(title: "SUCCESS", message: "You Have Successfully Registered")
                        self.goBack()
                    case .failure(let error):
                        self.viewDelegate?.showAlert(title: "ERROR", message: error.localizedDescription)
                    }
                }
                
            case .failure(let error):
                self.viewDelegate?.showAlert(title: "ERROR", message: error.localizedDescription)
            }
        }
    }
    
    func goBack(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            self.router.navigateBack()
        }
    }
}
