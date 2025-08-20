//
//  AreaViewController.swift
//  RecipeApp
//
//  Created by Yasin Özdemir on 13.10.2024.
//  
//

import UIKit

final class AreaViewController: ListVC {
    
    // MARK: - Properties
    var presenter: ViewToPresenterAreaProtocol!

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
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
        let area = presenter.getArea(for: indexPath)
        cell.set(title: area.name, imagePath: area.imageName)
            return cell
    }
}
    
extension AreaViewController: PresenterToViewAreaProtocol{
    
    
}
