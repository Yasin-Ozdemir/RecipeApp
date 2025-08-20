//
//  InstructionViewController.swift
//  RecipeApp
//
//  Created by Yasin Özdemir on 2.10.2024.
//

import UIKit
import WebKit
import SnapKit
final class InstructionViewController: UIViewController {
    private var instructionLenght = 0
    private let textView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 15)
        textView.textColor = .label
        textView.isEditable = false
        textView.textAlignment = .left
        textView.isScrollEnabled = true
        textView.backgroundColor = UIColor.secondarySystemBackground

        return textView
    }()

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    convenience init(meal: [String: String?], instructionLenght: Int) {
        self.init(nibName: nil, bundle: nil)
        self.instructionLenght = instructionLenght
        set(meal: meal)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
    }


    private func configureVC() {
        self.view.backgroundColor = .secondarySystemBackground
        self.view.layer.cornerRadius = 10
        self.textView.backgroundColor = .secondarySystemBackground
        self.view.addSubview(textView)
        applyConstraints()
    }

    private func applyConstraints() {
        let padding = 10
        let textViewHeight: Double = (Double(instructionLenght) / 40) * 17
        textView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(padding)
            make.leading.equalToSuperview().offset(padding)
            make.trailing.equalToSuperview().inset(padding)
            make.height.equalTo(textViewHeight)
        }

    }

    private func set(meal: [String: String?]) {
        guard let text = meal["strInstructions"] as? String else {
            self.textView.text = "UNKOWN"
            return
        }
        self.textView.text = text


    }


}
