//
//  AlertMessage.swift
//  Detailes
//
//  Created by MacBook on 12/28/19.
//  Copyright © 2019 Rania. All rights reserved.
//

import Foundation
import UIKit
import SwiftMessages

extension UIViewController {
    
    func showAlert(title : String, messages : [String]?, message: String?, selfDismissing: Bool) {
        
        var messageContent = ""
        
        if let messages = messages {
            for message in messages {
                messageContent += message + "\n"
            }
        }
        
        if let message = message {
            messageContent = message
        }
        
        let alert = UIAlertController(title: title, message: messageContent, preferredStyle: .alert)
        
        
        if !selfDismissing {
            let title = NSLocalizedString("OK".localized, comment: "Any")
            alert.addAction(UIAlertAction(title: title, style: .cancel, handler: nil))
        }
        
        present(alert, animated: true)
        
        if selfDismissing {
            let deadlineTime = DispatchTime.now() + .seconds(2)
            DispatchQueue.main.asyncAfter(deadline: deadlineTime) { [weak self] in
                alert.dismiss(animated: true)
            } }
    }
    
    var isInteractionEnabled: Bool {
        get {
            return true
        }
        set {
            if !isInteractionEnabled {
                UIApplication.shared.beginIgnoringInteractionEvents()
            } else {
                UIApplication.shared.endIgnoringInteractionEvents()
            }
        }
    }
    
    func interactionEnable(with indicator: UIActivityIndicatorView) {
        if indicator.isHidden {
            indicator.isHidden = false
            indicator.startAnimating()
            UIApplication.shared.beginIgnoringInteractionEvents()
        } else {
            indicator.isHidden = true
            indicator.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
        }
    }

    func alertImage(text : String , imageName : String){
        let alert = UIAlertController(title: "\(text)", message: "\n\n\n", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
            UIAlertAction in
            NSLog("Cancel Pressed")
        }
        alert.addAction(cancelAction)
        let image = UIImageView(image: UIImage(named: "\(imageName)"))
        alert.view.addSubview(image)
        image.translatesAutoresizingMaskIntoConstraints = false
        alert.view.addConstraint(NSLayoutConstraint(item: image, attribute: .centerX, relatedBy: .equal, toItem: alert.view, attribute: .centerX, multiplier: 1, constant: 0))
        alert.view.addConstraint(NSLayoutConstraint(item: image, attribute: .centerY, relatedBy: .equal, toItem: alert.view, attribute: .centerY, multiplier: 1, constant: 0))
        alert.view.addConstraint(NSLayoutConstraint(item: image, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 64.0))
        alert.view.addConstraint(NSLayoutConstraint(item: image, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 64.0))
        self.present(alert, animated: true, completion: nil)
    }
    
    func loginAlertMessage(){
        let alertController = UIAlertController(title: "Please Login At First".localize, message: "", preferredStyle: .alert)
        
        // Create the actions
        let okAction = UIAlertAction(title: "Login".localize, style: UIAlertAction.Style.default) {
            UIAlertAction in
//            var viewO = ViewObjects()
//            
//            let vc = viewO.loginVC
//            
//            self.show(vc!, sender: nil)

//            self.navigationController?.pushViewController(vc!, animated: true)
            NSLog("OK Pressed")
        }
        let cancelAction = UIAlertAction(title: "Cancel".localize, style: UIAlertAction.Style.cancel) {
            UIAlertAction in
            
            NSLog("Cancel Pressed")
        }
        
        // Add the actions
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        // Present the controller
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showToast(message : String ) {
        
        let toastLabel = UILabel(frame: CGRect(x: 0 , y: self.view.frame.size.height-250, width: self.view.frame.width - 10, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Cairo-Regular", size: 17.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}
extension UIAlertAction {
    var titleTextColor: UIColor? {
        get {
            return self.value(forKey: "titleTextColor") as? UIColor
        } set {
            self.setValue(newValue, forKey: "titleTextColor")
        }
    }
}
