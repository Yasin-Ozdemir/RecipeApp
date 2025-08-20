//
//  HomeViewPresenter.swift
//  RecipeApp
//
//  Created by Yasin Özdemir on 12.09.2024.
//

import Foundation

protocol HomeViewToPresenterProtocol : AnyObject{
    var viewControllerDelegate : HomePresenterToViewControllerProtocol? {get set}
    var router : HomePresenterToRouterProtocol! {get set}
    
    func goDetailVC(with recipe : Recipe , title : String)
}
final class HomePresenter : HomeViewToPresenterProtocol{
    weak var viewControllerDelegate : HomePresenterToViewControllerProtocol?
    var router : HomePresenterToRouterProtocol!
    
    func goDetailVC(with recipe : Recipe , title : String){
        router.navigateDetailVC(with: recipe , title : title)
    }
    
    
}
