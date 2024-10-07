//
//  SignOnViewController.swift
//  RecipeApp
//
//  Created by Yasin Özdemir on 19.09.2024.
//

import UIKit

protocol SignOnPresenterToViewProtocol : AnyObject{
    func showAlert(title: String, message: String)
}
class SignOnViewController: UIViewController {
    private let imageView : UIImageView = {
        let imageView = UIImageView(image: UIImage(resource: .recipeAppLogo))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private var mailTextField = SignTextField(placeHolder: "Please Enter Your Mail", hideText: false)
    private var passwordTextField = SignTextField(placeHolder: "Please Enter Your Password", hideText: true)
    private var nameTextField = SignTextField(placeHolder: "Please Enter Name and Surname", hideText: false)
    private var joinUsLabel = TitleLabel(align: .center, size: 25)
    private var signOnButton = CustomButton(backgroundColor: ColorConstants.mainColor, title: "Sign On", titleColor: .label)
    var presenter : SignOnViewToPresenterProtocol!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        
    }
    
    private func configureVC(){
        self.view.backgroundColor = .systemBackground
        self.view.addSubviews(imageView  , nameTextField, mailTextField,passwordTextField,signOnButton , joinUsLabel)
        
        self.signOnButton.addTarget(self, action: #selector(signOnButtonClicked), for: .touchUpInside)
        self.joinUsLabel.text = "LET'S JOIN US!"
        applyConstraints()
    }
    
    private func applyConstraints(){
        self.imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(100)
            make.height.equalToSuperview().multipliedBy(0.25)
            make.width.equalTo(imageView.snp.height)
        }
        self.joinUsLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(20)
            make.height.equalTo(27)
            make.width.equalToSuperview().multipliedBy(0.8)
        }
        self.nameTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(joinUsLabel.snp.bottom).offset(30)
            make.width.equalToSuperview().multipliedBy(0.7)
            make.height.equalTo(37)
        }
        self.mailTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(nameTextField.snp.bottom).offset(20)
            make.width.equalToSuperview().multipliedBy(0.7)
            make.height.equalTo(37)
        }
        self.passwordTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(mailTextField.snp.bottom).offset(20)
            make.width.equalToSuperview().multipliedBy(0.7)
            make.height.equalTo(37)
        }
        
        self.signOnButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.equalTo(40)
        }
    }
    
   @objc func signOnButtonClicked(){
        if controlTextFields() {
            presenter.registerUser(mail: mailTextField.text! , password: passwordTextField.text!, name: nameTextField.text!)
        }else{
            self.showAlert(title: "UPSS!", message: "Please Enter Your Informations.")
        }
        
    }
    
    func controlTextFields() -> Bool {
        guard let name = nameTextField.text , let mail = mailTextField.text,let password = passwordTextField.text else {
            return false
        }
        
        if name.isEmpty || mail.isEmpty || password.isEmpty {
            return false
        }
        
        return true
    }
}
extension SignOnViewController : SignOnPresenterToViewProtocol {
    func showAlert(title: String, message: String) {
        self.showCustomAlert(title: title, message: message)
   }
}
