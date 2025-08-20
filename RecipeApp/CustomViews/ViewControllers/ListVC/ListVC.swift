//
//  ListVC.swift
//  RecipeApp
//
//  Created by Yasin Özdemir on 13.09.2024.
//

import UIKit
import SnapKit

protocol ListPresenterToViewControllerProtocol : AnyObject {
    func showAlert(title: String,message : String)
    func reloadCollectionView()
    func goDetailVC(with recipe : Recipe , title : String)
}

 class ListVC: UIViewController {
    weak var homeViewDelegate : SubViewsToHomeViewsProtocol?
    
    private let titleLabel = TitleLabel(align: .left, size: 25)
    private var collectionView : UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        setupUI()
    }
  
   
    private func setupUI(){
        
        self.view.addSubviews(titleLabel , collectionView)
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview()
            make.height.equalTo(27)
        }
        
        self.collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(7)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(5)
        }
    }
}


extension ListVC : ListPresenterToViewControllerProtocol {
    func showAlert(title: String,message : String){
        self.showCustomAlert(title: title, message: message)
    }
    
    
    func reloadCollectionView(){
        self.collectionView.reloadData()
    }
    
    func goDetailVC(with recipe : Recipe , title : String) {
        homeViewDelegate?.goDetailVC(with: recipe ,  title : title)
    }
}


extension ListVC : UICollectionViewDelegate , UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
   
    }
    
    func configureCollectionView(){
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: CollectionViewFlowLayouts.createThreeColumnLayout(with: self.view.bounds.width))
        collectionView.register(ListCollectionViewCell.self, forCellWithReuseIdentifier: ListCollectionViewCell.cellID)
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    

    
}
