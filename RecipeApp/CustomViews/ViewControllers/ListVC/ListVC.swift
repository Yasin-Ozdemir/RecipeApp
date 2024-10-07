//
//  ListVC.swift
//  RecipeApp
//
//  Created by Yasin Özdemir on 13.09.2024.
//
enum ListType {
    case categories
    case areas
}
import UIKit
import SnapKit

protocol ListPresenterToViewControllerProtocol : AnyObject {
    func showError(message : String)
    func reloadCollectionView()
    func goDetailVC(with recipe : Recipe , title : String)
}

class ListVC: UIViewController {
    var type : ListType!
    var presenter : ListViewControllerToPresenterProtocol!
    weak var homeViewDelegate : SubViewsToHomeViewsProtocol?
    
    private let titleLabel = TitleLabel(align: .left, size: 25)
    private var collectionView : UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        setupUI()
        presenter.viewDidLoad()
    }
  
    var categoryList : [CategoryElement] = []
    
    init(type : ListType) {
        super.init(nibName: nil, bundle: nil)
        self.type = type
        setupLabels()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    private func setupLabels(){
        switch type {
        case .categories:
            self.titleLabel.text = "Categories"
            break
        case .areas:
            self.titleLabel.text = "Areas"
            break
        case .none:
            break
        }
    }
}


extension ListVC : ListPresenterToViewControllerProtocol {
    func showError(message : String){
        self.showCustomAlert(title: "UUPPS!", message: message)
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
        if type == .areas {
            return presenter.getAreaList().count
        }
        return presenter.getCategoryList().count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCollectionViewCell.cellID, for: indexPath) as? ListCollectionViewCell else{
            return UICollectionViewCell()
        }
        if type == .areas{
            cell.setForCategoryAndArea(listType: .areas, model: (area: presenter.getAreaList()[indexPath.row], category: nil))
            return cell
        }else{
            cell.setForCategoryAndArea(listType: .categories, model: (nil,presenter.getCategoryList()[indexPath.row]))
            return cell
        }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectItem(At: indexPath, type: type)
    }
    
    func configureCollectionView(){
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: CollectionViewFlowLayouts.createThreeColumnLayout(with: self.view.bounds.width))
        collectionView.register(ListCollectionViewCell.self, forCellWithReuseIdentifier: ListCollectionViewCell.cellID)
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    

    
}
