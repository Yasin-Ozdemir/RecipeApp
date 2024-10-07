//
//  MainTabBarController.swift
//  RecipeApp
//
//  Created by Yasin Özdemir on 12.09.2024.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        createTabBar()
        
    }
    
    
    func createTabBar(){
        UITabBar.appearance().tintColor = ColorConstants.mainColor
        UITabBar.appearance().backgroundColor = .secondarySystemBackground
        viewControllers = [setupHomeScreen() , setupFavoriteScreen() , setupProfileScreen()]
    }
    
    func setupProfileScreen() -> UINavigationController{
        let profileScreen = ProfileRouter.generateModule()
        profileScreen.tabBarItem.image = UIImage(systemName: SFSymbols.profile.rawValue)
        profileScreen.tabBarItem.title = "Profile"
        return UINavigationController(rootViewController: profileScreen)
    }
    
    func setupFavoriteScreen() -> UINavigationController{
        let favoriteScreen = FavoriteRouter.generateModule()
        favoriteScreen.tabBarItem.image = UIImage(systemName: "star.fill")
        favoriteScreen.tabBarItem.title = "Favorites"
        return UINavigationController(rootViewController: favoriteScreen)
    }
    func setupHomeScreen() -> UINavigationController{
        let homeScreen = HomeRouter.generateModule()
        homeScreen.tabBarItem.image = UIImage(systemName: "house.fill")
        homeScreen.tabBarItem.title = "Home"
        return UINavigationController(rootViewController: homeScreen)
    }
    func getCurrentUserInfos(id: String){
        FirebaseManager().fetchUserFromDatabase(with: id) { result in
            switch result {
            case .success(let user):
                CurrentUser.user.id = id
                CurrentUser.user.name = user.name
                CurrentUser.user.mail = user.mail
                CurrentUser.user.password = user.password
            case .failure(let error):
                break
            }
        }
    }
    
}

