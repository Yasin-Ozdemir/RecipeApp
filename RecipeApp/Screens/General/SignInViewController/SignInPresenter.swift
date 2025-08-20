//
//  SignInPresenter.swift
//  RecipeApp
//
//  Created by Yasin Özdemir on 19.09.2024.
//

import Foundation
protocol SignInViewToPresenterProtocol {
    var viewDelegate : SignInPresenterToViewProtocol? {get set}
    var interactor : SignInPresenterToInteractorProtocol! {get set}
    var router : SignInPresenterToRouterProtocol! {get set}
    
    func signIn(mail : String , password : String )
    func goSignOnVC()
}
final class SignInPresenter : SignInViewToPresenterProtocol {
    weak var viewDelegate: SignInPresenterToViewProtocol?
    var interactor:  SignInPresenterToInteractorProtocol!
    var router: SignInPresenterToRouterProtocol!
    
    func signIn(mail : String , password : String ){
        interactor.signIn(mail: mail, password: password) { result in
            switch result {
            case .success(let userId) :
                self.interactor.fetchUserInfos(id: userId) { result in
                    switch result {
                    case .success(let user):
                        self.setupCurrentUser(user: user)
                        self.goHomeVC()
                        
                    case .failure(let error):
                        self.viewDelegate?.showAlert(title: "ERROR", message: error.localizedDescription)
                    }
                }
            case .failure(let error) :
                self.viewDelegate?.showAlert(title: "ERROR", message: error.localizedDescription)
            }
        }
    }
    private func setupCurrentUser(user : User){
        CurrentUser.user.id = user.id
        CurrentUser.user.mail = user.mail
        CurrentUser.user.name = user.name
        CurrentUser.user.password = user.password
    }
   private func goHomeVC(){
        router.navigateHomeVC()
    }
    
    func goSignOnVC(){
        router.navigateSignOnVC()
    }
}
