//
//  RecipeDetailViewController.swift
//  RecipeApp
//
//  Created by Yasin Özdemir on 19.09.2024.
//

import UIKit
import SnapKit
protocol RecipeDetailPresenterToViewProtocol : AnyObject{
    func showAlert(title : String ,message: String)
    func updateFavoriteButton()
}
class RecipeDetailViewController: UIViewController {
    var presenter : RecipeDetailViewToPresenterProtocol!
    private var isFavorite = false
    
    private var headerContainerView = UIView()
    private var ingredientsContainerView = UIView()
    private var instructionContainerView = UIView()
    private var webContainerView = UIView()
    private let contentView = UIView()
    
    private let activityIndicator : UIActivityIndicatorView = {
       let indicator = UIActivityIndicatorView()
        indicator.style = .large
        indicator.color = ColorConstants.mainColor
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    var scrollView : UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private let ingredientTitleLabel = TitleLabel(align: .left, size: 28)
    private let instructionTitleLabel = TitleLabel(align: .left, size: 28)
    private let webTitleLabel = TitleLabel(align: .left, size: 28)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        configureVC()
        setupUI()
        setupNavigationController()
    }
   private func setupUI(){
       self.view.backgroundColor = .systemBackground
       self.contentView.backgroundColor = .systemBackground
       self.ingredientTitleLabel.text = "Ingredients"
       self.instructionTitleLabel.text = "Instruction"
       self.webTitleLabel.text = "Video"
        view.addSubview(scrollView)
       scrollView.addSubview(contentView)
       contentView.addSubviews(headerContainerView , ingredientsContainerView , instructionContainerView, ingredientTitleLabel , instructionTitleLabel,webTitleLabel,webContainerView , activityIndicator)
       applyConstraints()
    }
    
    private func applyConstraints(){
        
        self.scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        self.activityIndicator.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        let contentHeight = ((Double(presenter.getInstructionLenght()) / 40 * 16.2 + 30) * 1.1 + Double(SizeConstants.ingredientHeiht) * 1.1 ) + Double(630)
        self.contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(contentHeight)
        }
        let padding = 10
        headerContainerView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(padding)
            make.trailing.equalToSuperview().inset(padding)
            make.top.equalToSuperview().offset(10)
            make.height.equalTo(200)
        }
        
        ingredientTitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(padding)
            make.trailing.equalToSuperview().inset(padding)
            make.top.equalTo(headerContainerView.snp.bottom).offset(25)
            make.height.equalTo(30)
        }
       ingredientsContainerView.snp.makeConstraints { make in
           make.leading.equalToSuperview().offset(padding)
           make.trailing.equalToSuperview().inset(padding)
           make.top.equalTo(ingredientTitleLabel.snp.bottom).offset(padding)
           make.height.equalTo(SizeConstants.ingredientHeiht)
       }
        instructionTitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(padding)
            make.trailing.equalToSuperview().inset(padding)
            make.top.equalTo(ingredientsContainerView.snp.bottom).offset(25)
            make.height.equalTo(30)
        }
        let instructionContainerHeight = Double(presenter.getInstructionLenght()) / 40 * 16.2  +  30
        instructionContainerView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(padding)
            make.trailing.equalToSuperview().inset(padding)
            make.top.equalTo(instructionTitleLabel.snp.bottom).offset(padding)
            make.height.equalTo(instructionContainerHeight)
        }
        webTitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(padding)
            make.trailing.equalToSuperview().inset(padding)
            make.top.equalTo(instructionContainerView.snp.bottom).offset(25)
            make.height.equalTo(30)
        }
        webContainerView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(padding)
            make.trailing.equalToSuperview().inset(padding)
            make.top.equalTo(webTitleLabel.snp.bottom).offset(padding)
            make.height.equalTo(250)
        }

    }
    private func setupNavigationController(){
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationBar.tintColor = ColorConstants.mainColor
        self.navigationController?.navigationBar.barStyle = .default
     
        let closeButton = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(closeVC))
        self.navigationItem.leftBarButtonItem = closeButton
        setupFavoriteButton()
        
    }
    
    func setupFavoriteButton(){
        var favoriteButton = UIBarButtonItem()
        if presenter.isFavoriteControl() {
            favoriteButton = UIBarButtonItem(image: UIImage(systemName: SFSymbols.fovoriteFilled.rawValue), style: .done, target: self , action: #selector(removeFavorite))

        }else{
            favoriteButton = UIBarButtonItem(image: UIImage(systemName: SFSymbols.favorite.rawValue), style: .done, target: self, action: #selector(addFavorite))
        }
        self.navigationItem.rightBarButtonItem = favoriteButton
    }
   
    @objc func addFavorite(){
        presenter.addFavorite()
    }
    @objc func removeFavorite(){
        presenter.removeFavorite()
    }
    @objc func closeVC(){
        self.dismiss(animated: true)
    }
   private func configureVC(){
       add(childVC: RecipeDetailHeaderViewController(recipe: presenter.recipe), to: headerContainerView)
       add(childVC: IngredientsViewController(meal: presenter.recipe), to: ingredientsContainerView)
       add(childVC: InstructionViewController(meal: presenter.recipe, instructionLenght: presenter.getInstructionLenght()), to: instructionContainerView)
       add(childVC: VideoViewController(videoUrl: presenter.recipe["strYoutube"]!), to: webContainerView)
    }
    func add(childVC : UIViewController , to containerView: UIView){
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds // vc to fill up whole view controller
        childVC.didMove(toParent: self)
    }
    
    
}
extension RecipeDetailViewController : RecipeDetailPresenterToViewProtocol {
    func showAlert(title : String ,message: String) {
        self.showCustomAlert(title: title, message: message)
    }
    
    func updateFavoriteButton(){
        setupFavoriteButton()
    }
}

