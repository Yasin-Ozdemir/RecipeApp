//
//  CustomAlertController.swift
//  RecipeApp
//
//  Created by Yasin Özdemir on 14.09.2024.
//

import UIKit
import SnapKit
class CustomAlertController: UIViewController {
    let container : UIView = {
        let container = UIView()
        container.layer.cornerRadius = 16
        container.layer.borderColor = UIColor.white.cgColor
        container.layer.borderWidth = 2
        container.backgroundColor = ColorConstants.mainColor
        return container
    }()
    let titleLabel = TitleLabel(align: .center, size: 20)
    let bodyLabel = BodyLabel(align: .center, size: 15, color: .label)
    let button = CustomButton(backgroundColor:  UIColor.white, title: "OK", titleColor: .black)
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        applyConstraints()
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    convenience init(title : String , message : String) {
        self.init(nibName: nil, bundle: nil)
        self.titleLabel.text = title
        self.bodyLabel.text = message
    }
    func setupUI(){
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        view.addSubview(container)
        container.addSubviews(titleLabel , bodyLabel , button)
        applyConstraints()
        addButtonAction()
    }
    
    func applyConstraints(){
        self.container.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(115)
            make.width.equalTo(180)
        }
        
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().inset(8)
            make.height.equalTo(22)
        }
        
        self.bodyLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().inset(8)
            make.top.equalTo(titleLabel.snp.bottom).offset(0)
            make.height.equalTo(37)
        }
        
        self.button.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().inset(25)
            make.top.equalTo(bodyLabel.snp.bottom).offset(8)
            make.height.equalTo(26)
        }
    }
    
    func addButtonAction(){
        self.button.addTarget(self, action: #selector(dismissAlert), for: .touchUpInside)
    }
    @objc func dismissAlert(){
        self.dismiss(animated: true)
    }
}

