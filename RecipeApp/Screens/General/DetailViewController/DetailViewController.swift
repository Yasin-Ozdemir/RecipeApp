//
//  DetailViewController.swift
//  RecipeApp
//
//  Created by Yasin Özdemir on 28.09.2024.
//

import UIKit
protocol DetailPresenterToViewProtocol : AnyObject{
    func showError(message : String)
}
class DetailViewController: UIViewController {
  
    var presenter : DetailViewToPresenterProtocol!
    private var tableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        configureTableView()
       
    }
  
    func setupNavigationController(title : String){
        self.navigationItem.title = title
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.tintColor = ColorConstants.mainColor
        self.navigationItem.hidesBackButton = false
    }
    func configureTableView(){
        self.tableView = .init(frame: .zero)
        self.tableView.register(RecipeTableViewCell.self, forCellReuseIdentifier: RecipeTableViewCell.cellId)
        self.tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(self.tableView)
        applyConstraints()
    }
    private func applyConstraints(){
        self.tableView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().inset(12)
            make.top.equalToSuperview().offset(12)
            make.bottom.equalToSuperview().inset(12)
        }
    }

}

extension DetailViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecipeTableViewCell.cellId, for: indexPath) as? RecipeTableViewCell else {
            return UITableViewCell()
        }
        
        cell.set(recipe: presenter.getRecipe(at: indexPath))
        return cell
     }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectItem(at: indexPath)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        110
    }
    
}

extension DetailViewController : DetailPresenterToViewProtocol {
    func showError(message : String) {
        self.showCustomAlert(title: "ERROR", message: "Something Get Wrong!")
    }
    
    
}
