//
//  ProfileViewController.swift
//  RecipeApp
//
//  Created by Yasin Özdemir on 12.09.2024.
//

import UIKit
import SnapKit
protocol ProfilePresenterToViewControllerProtocol : AnyObject{
    func showAlert(title : String , message : String)
}
class ProfileViewController: UIViewController {
    var presenter : ProfileViewControllerToPresenterProtocol!
    
    private let titleLabel = TitleLabel(align: .center, size: 27)
    private let tableView : UITableView = {
       let tableView = UITableView()
        tableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: ProfileTableViewCell.cellID )
        tableView.isScrollEnabled = false
        tableView.backgroundColor = .systemBackground
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupTableView()
        setupUI()
       
    }
    private func setupUI(){
        self.view.addSubviews(titleLabel , tableView)
        self.navigationItem.title = "Profile"
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.prefersLargeTitles = true
        titleLabel.text = "Hello \(CurrentUser.user.name)!"
        
        self.titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(29)
            make.top.equalToSuperview().offset(200)
        }
        self.tableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().inset(15)
            make.height.equalToSuperview().multipliedBy(0.57)
        }
    }
}

extension ProfileViewController : ProfilePresenterToViewControllerProtocol{
    func showAlert(title: String, message: String) {
        self.showCustomAlert(title: title, message: message)
    }
    
    
}

extension ProfileViewController : UITableViewDelegate , UITableViewDataSource {
    func setupTableView(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.cellID, for: indexPath) as? ProfileTableViewCell else {
            return ProfileTableViewCell()
        }
        let item = presenter.getProfileItem(for: indexPath)
        cell.setItems(imagePath: item.imagePath, title: item.title)
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 5 {
            
            presenter.exit()
        }
        if indexPath.row == 0 {
            self.tabBarController?.selectedIndex = 1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        75
    }
  
}

