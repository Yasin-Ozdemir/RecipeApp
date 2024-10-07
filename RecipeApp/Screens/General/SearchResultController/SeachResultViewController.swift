//
//  SeachResultViewController.swift
//  RecipeApp
//
//  Created by Yasin Özdemir on 15.09.2024.
//

import UIKit
enum Section {
    case main
}
protocol SearchPresenterToViewControllerProtocol : AnyObject {
    func updateCollectionView()
    func showError(message : String)
}
class SearchResultViewController: UIViewController {
    private var dataSource  : UICollectionViewDiffableDataSource<Section , [String: String?]>!
    private var collectionView : UICollectionView!
    var presenter : SearchViewControllerToPresenterProtocol!
    var emptyView : UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        configureDataSource()
    }
    func search(with recipeName : String){
        presenter.search(with: recipeName)
     
    }
   
   private func setupCollectionView(){
        
       self.collectionView = .init(frame: view.bounds, collectionViewLayout: CollectionViewFlowLayouts.createTwoColumnLayout(with: view.bounds.width, scrollDirection: .vertical))
    
        collectionView.register(ListCollectionViewCell.self, forCellWithReuseIdentifier: ListCollectionViewCell.cellID)
        
        collectionView.delegate = self
       self.collectionView.showsVerticalScrollIndicator = false
        view.addSubview(self.collectionView)
    }
    
}

extension SearchResultViewController : UICollectionViewDelegate {
    private func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.presenter.numberOfItemsInSection()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("clicked")
        DispatchQueue.main.async {
            self.presenter.goRecipeDetailVC(for: indexPath)
        }
        
    }
    private func configureDataSource(){
        dataSource = UICollectionViewDiffableDataSource<Section,[String : String?]>(collectionView: collectionView) { collectionView, indexPath, item in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCollectionViewCell.cellID, for: indexPath) as! ListCollectionViewCell
            cell.setForSearchResult(recipe: item)
            return cell
        }
    }
    
}

extension SearchResultViewController : SearchPresenterToViewControllerProtocol {
    func updateCollectionView(){
        self.removeEmptyVC()
        var snapShot = NSDiffableDataSourceSnapshot<Section , [String : String?]>()
        snapShot.appendSections([.main])
        let list = presenter.getRecipesList()
        snapShot.appendItems(list)
        DispatchQueue.main.async {
            self.dataSource.apply(snapShot, animatingDifferences: true)
           if list == [] {
                self.showEmptyVC()
            }
        }
    }
    
    func showError(message : String){
        self.showCustomAlert(title: "UUPS!", message: message)
    }
    
    func showEmptyVC(){
            DispatchQueue.main.async {
                self.emptyView = EmptyResultView(frame: self.view.bounds)
                self.view.addSubview(self.emptyView!)
            }
    }
    func removeEmptyVC(){
        DispatchQueue.main.async {
            self.emptyView?.removeFromSuperview()
            self.emptyView = nil
        }
    }
}
