//
//  VideoViewController.swift
//  RecipeApp
//
//  Created by Yasin Özdemir on 2.10.2024.
//

import UIKit
import SnapKit
import WebKit
class VideoViewController: UIViewController {
    
    private let webView : WKWebView = {
       let webView = WKWebView()
        return webView
    }()
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  convenience  init(videoUrl : String?) {
      self.init(nibName: nil, bundle: nil)
      set(videoUrl: videoUrl)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .secondarySystemBackground
        self.view.layer.cornerRadius = 10
        view.addSubview(webView)
        applyConstraints()
        // Do any additional setup after loading the view.
    }
    
    func applyConstraints(){
        let padding = 25
        webView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(padding)
            make.trailing.equalToSuperview().inset(padding)
            make.height.equalTo(200)
        }
    }
    
    func set(videoUrl : String?) {
        guard let urlString = videoUrl  , let url = URL(string:getVideoUrl(urlString: urlString)) else{
            return
        }
        self.webView.load(URLRequest(url: url))
    }
    private func getVideoUrl(urlString : String) -> String{
        let targetChar : Character = "="
        if let range = urlString.range(of: String(targetChar)) {
            // Karakterden sonrasını alma
            let substring = urlString[range.upperBound...]
            let resultString = String(substring) // Substring'i string'e çevirme

            print("Sonuç: \(resultString)")
            return NetworkConstants.youtubeBaseUrl.rawValue + resultString
        } else {
            return ""
        }
    }
}
