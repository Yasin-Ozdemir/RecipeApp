//
//  FavoriteViewController.swift
//  RecipeApp
//
//  Created by Yasin Özdemir on 12.09.2024.
//

import UIKit

protocol FavoritePresenterToViewControllerProtocol: AnyObject{
    func showAlert(title: String, message: String)
    func reloadTableView()
    func deleteRow(indexPath : IndexPath)
}
final class FavoriteViewController: UIViewController {
    var presenter : FavoriteViewControllerToPresenterProtocol!
    
    private var tableView : UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupTableView()
        setupNavigationController()
        presenter.viewDidLoad()
    }
    private func setupNavigationController(){
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Favorites"
        self.navigationController?.navigationBar.tintColor = ColorConstants.mainColor
    
    }
}

extension FavoriteViewController : UITableViewDelegate , UITableViewDataSource {
    private func setupTableView(){
        self.tableView = .init(frame: view.bounds)
        view.addSubview(self.tableView)
        self.tableView.register(RecipeTableViewCell.self, forCellReuseIdentifier: RecipeTableViewCell.cellId)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecipeTableViewCell.cellId, for: indexPath) as? RecipeTableViewCell else{
            return UITableViewCell()
        }
        let recipe = presenter.getRecipe(for: indexPath)
        cell.set(recipe: recipe)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectRow(At: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        110
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            presenter.deleteRecipe(at: indexPath)
        }
            
    }
}
extension FavoriteViewController : FavoritePresenterToViewControllerProtocol {
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    
    func showAlert(title: String, message: String){
        self.showCustomAlert(title: title, message: message)
    }
    func deleteRow(indexPath : IndexPath){
        DispatchQueue.main.async {
            self.tableView.deleteRows(at: [indexPath], with: .right)
        }
        
    }
}
