//
//  UIViewController+Ext.swift
//  RecipeApp
//
//  Created by Yasin Özdemir on 14.09.2024.
//

import Foundation
import UIKit
import SnapKit
fileprivate var containerView : UIView?
extension UIViewController{
   
    func showCustomAlert(title : String , message : String){
        DispatchQueue.main.async {
            let alertController = CustomAlertController(title: title, message: message)
            alertController.modalPresentationStyle = .overFullScreen
            alertController.modalTransitionStyle = .crossDissolve
            self.present(alertController, animated: true)
        }
    }
    
    
    func showActivityProgressIndicator(){
        containerView = UIView(frame: self.view.bounds)
        self.view.addSubview(containerView!)
        
        containerView!.backgroundColor = .systemBackground
       
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .large
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = ColorConstants.mainColor
        
        DispatchQueue.main.async {
            containerView!.addSubview(activityIndicator)
            
            activityIndicator.snp.makeConstraints { make in
                make.center.equalToSuperview()
            }
            activityIndicator.startAnimating()
        }
        
    }
    
    
    func dismissActivityProgressIndicator(){
        DispatchQueue.global().asyncAfter(deadline: .now() + 1){
            DispatchQueue.main.async {
                containerView?.removeFromSuperview()
                containerView = nil
            }
        }
       
    }
}
