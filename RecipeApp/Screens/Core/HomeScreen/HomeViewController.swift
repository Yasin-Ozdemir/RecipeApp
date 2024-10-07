//
//  HomeViewController.swift
//  RecipeApp
//
//  Created by Yasin Özdemir on 12.09.2024.
//

import UIKit
import SnapKit
protocol SubViewsToHomeViewsProtocol : AnyObject{
    func showIndicator()
    func dismissIndicator()
    func goDetailVC(with recipe : Recipe , title : String)
}
protocol HomePresenterToViewControllerProtocol : AnyObject{
    
}
class HomeViewController: UIViewController {
    var presenter : HomeViewToPresenterProtocol!
    
    
    private let popularRecipesContainer = UIView()
    
    private let categoriesListContainer = UIView()
    
    private let areasListContainer = UIView()
    
    private let contentView = UIView()
    
    private var searchController : UISearchController = {
        let searchController = UISearchController(searchResultsController: SearchResultRouter.generateModule())
        searchController.searchBar.placeholder = "Please Enter The Recipe Name"
        searchController.searchBar.showsCancelButton = true
        searchController.searchBar.barTintColor = ColorConstants.mainColor
        return searchController
    }()
    
    private let scrollView : UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = true
        scrollView.isScrollEnabled = true
        return scrollView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupSearchBar()
        setupNavigationController()
        setupUILayouts()
        configureVC()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationController()
        
    }
    
    func setupSearchBar(){
        self.searchController.searchResultsUpdater = self
        self.searchController.isActive = true
    }
    
    
    func setupNavigationController(){
        self.navigationItem.title = "Home"
        self.navigationController?.navigationBar.tintColor = ColorConstants.mainColor
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.searchController = searchController
    }
    
    
    func setupUILayouts(){
        self.view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(800)
        }
        contentView.backgroundColor = .systemBackground
        self.contentView.addSubviews(popularRecipesContainer , categoriesListContainer, areasListContainer)
        
        popularRecipesContainer.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(295)
        }
        categoriesListContainer.snp.makeConstraints { make in
            make.top.equalTo(popularRecipesContainer.snp.bottom).offset(30)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(195)
        }
        areasListContainer.snp.makeConstraints { make in
            make.top.equalTo(categoriesListContainer.snp.bottom).offset(30)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(195)
        }
    }
    func configureVC(){
        guard let popularRecipesView =  PopularRecipesRouter.generateModule() as? PopularRecipesVC ,let categoriesList = ListRouter.generateModule(with: .categories) as? ListVC , let areasList = ListRouter.generateModule(with: .areas) as? ListVC  else {
            return
        }
        popularRecipesView.homeViewDelegate = self
        add(childVC: popularRecipesView, to: popularRecipesContainer)
        
        categoriesList.homeViewDelegate = self
        add(childVC: categoriesList, to: categoriesListContainer)
        
        areasList.homeViewDelegate = self
        add(childVC: areasList, to: areasListContainer)
    }
    
    func add(childVC: UIViewController, to containerView: UIView) {
         addChild(childVC)
         containerView.addSubview(childVC.view)
         childVC.view.frame = containerView.bounds // vc to fill up whole view controller
         childVC.didMove(toParent: self)
     }
}



extension HomeViewController : HomePresenterToViewControllerProtocol {
    
}



extension HomeViewController : SubViewsToHomeViewsProtocol {
    func showIndicator(){
        showActivityProgressIndicator()
    }
    func dismissIndicator(){
        dismissActivityProgressIndicator()
    }
    func goDetailVC(with recipe : Recipe , title : String){
        presenter.goDetailVC(with: recipe , title : title)
    }
}



extension HomeViewController : UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let recipeName = self.searchController.searchBar.text  ,let resultController = searchController.searchResultsController as? SearchResultViewController else {
            return
        }
        resultController.search(with: recipeName)
      
    }
    
    
}
