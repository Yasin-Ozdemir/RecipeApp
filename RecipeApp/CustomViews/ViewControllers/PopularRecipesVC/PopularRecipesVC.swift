//
//  PopularRecipesVC.swift
//  RecipeApp
//
//  Created by Yasin Özdemir on 12.09.2024.
//

import UIKit
import SnapKit


protocol PopularRecipesPresenterToViewControllerProtocol : AnyObject {
    var presenter : PopularRecipesViewControllerToPresenterProtocol! {get set}
    func showError()
    func reloadCollectionView()
    func showIndicator()
    func dismissIndicator()
}


class PopularRecipesVC: UIViewController {
    private var collectionView : UICollectionView!
    private let titleLabel = TitleLabel(align: .left, size: 25)
    var presenter : PopularRecipesViewControllerToPresenterProtocol!
    
    weak var homeViewDelegate : SubViewsToHomeViewsProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        configureCollectionView()
        setupUI()
       
    }
    
    
   private func setupUI(){
       self.titleLabel.text = "Populars"
       self.view.addSubviews(self.collectionView , titleLabel)
       
       titleLabel.snp.makeConstraints { make in
           make.top.equalToSuperview().offset(0)
           make.leading.equalToSuperview().offset(12)
           make.trailing.equalToSuperview()
           make.height.equalTo(27)
       }
       collectionView.snp.makeConstraints { make in
           make.top.equalTo(titleLabel.snp.bottom).offset(7)
           make.leading.equalToSuperview()
           make.trailing.equalToSuperview()
           make.bottom.equalToSuperview().offset(-5)
       }
       
    }

}


extension PopularRecipesVC : PopularRecipesPresenterToViewControllerProtocol {
    
    
    func showError(){
        self.showCustomAlert(title: "UUPPS!", message: "Something get wrong. Please try again.")
    }
    
    
    func reloadCollectionView(){
        self.collectionView.reloadData()
    }
    
    func showIndicator(){
        homeViewDelegate?.showIndicator()
    }
    func dismissIndicator(){
        homeViewDelegate?.dismissIndicator()
    }
}


extension PopularRecipesVC : UICollectionViewDelegate , UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.numberOfItemsInSection()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularRecipesCollectionViewCell.cellID, for: indexPath) as? PopularRecipesCollectionViewCell else{
            return UICollectionViewCell()
        }
        let meal = self.presenter.getPopularRecipes()[indexPath.row].meals?[0]
    
        cell.set(meal: meal)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("clicked")
        presenter.goRecipeDetailVC(for: indexPath)
    }
    
    func configureCollectionView(){
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: CollectionViewFlowLayouts.createTwoColumnLayout(with: self.view.bounds.width, scrollDirection: .horizontal))
        self.collectionView.register(PopularRecipesCollectionViewCell.self, forCellWithReuseIdentifier: PopularRecipesCollectionViewCell.cellID)
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
   
}


