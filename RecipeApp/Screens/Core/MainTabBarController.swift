//
//  MainTabBarController.swift
//  RecipeApp
//
//  Created by Yasin Özdemir on 12.09.2024.
//

import UIKit

final class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        createTabBar()
    }

    private func createTabBar() {
        UITabBar.appearance().tintColor = ColorConstants.mainColor
        UITabBar.appearance().backgroundColor = .secondarySystemBackground
        viewControllers = [setupHomeScreen(), setupFavoriteScreen(), setupProfileScreen()]
    }

    private func setupProfileScreen() -> UINavigationController {
        let profileScreen = ProfileRouter.generateModule()
        profileScreen.tabBarItem.image = UIImage(systemName: SFSymbols.profile.rawValue)
        profileScreen.tabBarItem.title = "Profile"
        return UINavigationController(rootViewController: profileScreen)
    }

    private  func setupFavoriteScreen() -> UINavigationController {
        let favoriteScreen = FavoriteRouter.generateModule()
        favoriteScreen.tabBarItem.image = UIImage(systemName: "star.fill")
        favoriteScreen.tabBarItem.title = "Favorites"
        return UINavigationController(rootViewController: favoriteScreen)
    }
    
    private  func setupHomeScreen() -> UINavigationController {
        let homeScreen = HomeRouter.generateModule()
        homeScreen.tabBarItem.image = UIImage(systemName: "house.fill")
        homeScreen.tabBarItem.title = "Home"
        return UINavigationController(rootViewController: homeScreen)
    }
    
      func getCurrentUserInfos(id: String) {
        UserFirestoreManager().fetchFromDB(collectionPath: "Users", documentId: id) { result in
            switch result {
            case .success(let users):
                guard let id = users[0]["id"] as? String, let name = users[0]["name"] as? String, let mail = users[0]["mail"] as? String, let password = users[0]["password"] as? String else {
                    return
                }
                CurrentUser.user.id = id
                CurrentUser.user.name = name
                CurrentUser.user.mail = mail
                CurrentUser.user.password = password
            case .failure(let error):
                break
            }
        }

    }

}

