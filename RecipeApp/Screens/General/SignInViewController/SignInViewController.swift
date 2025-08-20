//
//  SignInViewController.swift
//  RecipeApp
//
//  Created by Yasin Özdemir on 19.09.2024.
//

import UIKit
import SnapKit
protocol SignInPresenterToViewProtocol: AnyObject {
    func showAlert(title: String, message: String)
}
final class SignInViewController: UIViewController {

    private let imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(resource: .recipeAppLogo))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let createUserButton: UIButton = {
        let button = UIButton()
        button.setTitle("Create User", for: .normal)
        button.setTitleColor(.label, for: .normal)
        return button
    }()

    private var mailTextField = SignTextField(placeHolder: "Please Enter Your Mail", hideText: false)
    private var passwordTextField = SignTextField(placeHolder: "Please Enter Your Password", hideText: true)
    private var signInButton = CustomButton(backgroundColor: ColorConstants.mainColor, title: "Sign In", titleColor: .label)
    private var welcomeLabel = TitleLabel(align: .center, size: 25)

    var presenter: SignInViewToPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()

    }

    @objc func hideKeyboard() {
        view.endEditing(true) // Klavyeyi gizler
    }

    private func configureVC() {
        self.view.backgroundColor = .systemBackground
        self.view.addSubviews(imageView, createUserButton, mailTextField, passwordTextField, signInButton, welcomeLabel)
        setupNavigationController()

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)

        self.welcomeLabel.text = "WELCOME TO RECIPE APP"
        self.signInButton.addTarget(self, action: #selector(signInButtonClicked), for: .touchUpInside)
        self.createUserButton.addTarget(self, action: #selector(createUserButtonClicked), for: .touchUpInside)
        applyConstraints()
    }

    private func applyConstraints() {
        self.imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(120)
            make.height.equalToSuperview().multipliedBy(0.25)
            make.width.equalTo(imageView.snp.height)
        }
        self.welcomeLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(20)
            make.height.equalTo(27)
            make.width.equalToSuperview().multipliedBy(0.8)
        }
        self.mailTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(welcomeLabel.snp.bottom).offset(30)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(37)
        }
        self.passwordTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(mailTextField.snp.bottom).offset(20)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(37)
        }
        self.createUserButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(passwordTextField.snp.bottom).offset(30)
            make.width.equalToSuperview().multipliedBy(0.4)
            make.height.equalTo(15)
        }
        self.signInButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(createUserButton.snp.bottom).offset(20)
            make.width.equalToSuperview().multipliedBy(0.65)
            make.height.equalTo(40)
        }

    }

    private func setupNavigationController() {
        self.navigationController?.navigationBar.tintColor = ColorConstants.mainColor
    }

    @objc func createUserButtonClicked() {
        print("createButtonClicked")
        presenter.goSignOnVC()
    }

    @objc func signInButtonClicked() {
        guard let mail = self.mailTextField.text, let password = self.passwordTextField.text else {
            return
        }
        if mail != "" && password != "" {
            presenter.signIn(mail: mail, password: password)
        }

    }
}


extension SignInViewController: SignInPresenterToViewProtocol {
    func showAlert(title: String, message: String) {
        self.showCustomAlert(title: title, message: message)
    }
}
