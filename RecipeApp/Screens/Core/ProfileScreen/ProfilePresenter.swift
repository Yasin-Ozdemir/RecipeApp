//
//  ProfilePresenter.swift
//  RecipeApp
//
//  Created by Yasin Özdemir on 12.09.2024.
//

import Foundation

protocol ProfileViewControllerToPresenterProtocol : AnyObject{
    var viewControllerDelegate : ProfilePresenterToViewControllerProtocol? {get set}
    var interactor : ProfilePresenterToInteractorProtocol! {get set}
    var router : ProfilePresenterToRouterProtocol! {get set}
    
     func numberOfRowsInSection() -> Int
     func getProfileItem(for indexPath : IndexPath) -> ProfileItem
    func exit()
}

final class ProfilePresenter : ProfileViewControllerToPresenterProtocol{
    weak var viewControllerDelegate : ProfilePresenterToViewControllerProtocol?
    var interactor : ProfilePresenterToInteractorProtocol!
    var router : ProfilePresenterToRouterProtocol!
    
    private let profileItems = [ProfileItem(imagePath: .favorite, title: "Favorites") , ProfileItem(imagePath: .profile, title: "Account") , ProfileItem(imagePath: .settings, title: "Settings") , ProfileItem(imagePath: .info, title: "About Us") , ProfileItem(imagePath: .help, title: "Help") , ProfileItem(imagePath: .exit, title: "Exit")]
    
    public func numberOfRowsInSection() -> Int {
        return profileItems.count
    }
    public func getProfileItem(for indexPath : IndexPath) -> ProfileItem{
        return profileItems[indexPath.row]
    }
    
    func exit(){
        interactor.signOut { result in
            switch result {
            case .success(_):
                self.goSignInVC()
            case .failure(let error):
                self.viewControllerDelegate?.showAlert(title : "ERROR" , message : error.localizedDescription)
            }
        }
    }
    
    func goSignInVC(){
        router.navigateLogInVC()
    }
    
}
