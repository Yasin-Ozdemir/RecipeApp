//
//  CollectionViewFlowLayouts.swift
//  RecipeApp
//
//  Created by Yasin Özdemir on 7.10.2024.
//

import Foundation
import UIKit
struct CollectionViewFlowLayouts {
    static func createTwoColumnLayout(with viewWidth : CGFloat , scrollDirection : UICollectionView.ScrollDirection) -> UICollectionViewFlowLayout{
        let width = viewWidth
        let padding: CGFloat = 12
        let minimumItemSpacing: CGFloat = 10
        let availableWidth = width - (padding) - (minimumItemSpacing)
    let itemWidth = availableWidth / 2
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: padding, bottom: 0, right: padding)
    flowLayout.minimumInteritemSpacing = minimumItemSpacing
    flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth * 1.3)
    flowLayout.scrollDirection = scrollDirection
        return flowLayout
    }
    
    static func createThreeColumnLayout(with viewWidth : CGFloat) -> UICollectionViewFlowLayout {
        let width =  viewWidth
        let padding: CGFloat = 12
        let minimumItemSpacing: CGFloat = 10
    let availableWidth = width - (padding * 2.5) - (minimumItemSpacing * 2.5)
    let itemWidth = availableWidth / 3
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: padding, bottom: 0, right: padding)
    flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth * 1.22)
    flowLayout.scrollDirection = .horizontal
        return flowLayout
    }
}
