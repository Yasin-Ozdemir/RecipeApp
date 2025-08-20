//
//  CategoryViewController.swift
//  RecipeApp
//
//  Created by Yasin Özdemir on 13.10.2024.
//  
//

import UIKit

final class CategoryViewController: ListVC {
    
    // MARK: - Properties
    var presenter: ViewToPresenterCategoryProtocol!

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.numberOfItemsInSection()
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectItem(At: indexPath)
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCollectionViewCell.cellID, for: indexPath) as? ListCollectionViewCell else{
            return UICollectionViewCell()
        }
        let category = presenter.getCategory(for: indexPath)
        cell.set(title: category.strCategory, imagePath: category.strCategoryThumb)
            return cell
    }
}

extension CategoryViewController: PresenterToViewCategoryProtocol{
    // TODO: Implement View Output Methods
}
