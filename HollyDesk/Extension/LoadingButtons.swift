//
//  LoadingButtons.swift
//  osraty-user_ios
//
//  Created by apple on 4/26/20.
//  Copyright © 2020 panorama. All rights reserved.
//

import UIKit
protocol AnimatableView: class {
    func startAnimating()
    func stopAnimating()
}

class LoadingButton: UIButton, AnimatableView {
    
    var originalButtonText: String?
    var activityIndicator: UIActivityIndicatorView!
    
    @IBInspectable
    var activityIndicatorColor: UIColor = .white
    
    func startAnimating() {
        self.isUserInteractionEnabled = false
        originalButtonText = self.titleLabel?.text
        self.setTitle("", for: .normal)
        
        if (activityIndicator == nil) {
            activityIndicator = createActivityIndicator()
        }
        
        showSpinning()
    }
    
    func stopAnimating() {
        self.isUserInteractionEnabled = true
        self.setTitle(originalButtonText, for: .normal)
        activityIndicator.stopAnimating()
    }
    
    private func createActivityIndicator() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = activityIndicatorColor
        return activityIndicator
    }
    
    private func showSpinning() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(activityIndicator)
        centerActivityIndicatorInButton()
        activityIndicator.startAnimating()
    }
    
    private func centerActivityIndicatorInButton() {
        let xCenterConstraint = NSLayoutConstraint(item: self,
                                                   attribute: .centerX,
                                                   relatedBy: .equal,
                                                   toItem: activityIndicator,
                                                   attribute: .centerX,
                                                   multiplier: 1, constant: 0)
        self.addConstraint(xCenterConstraint)
        
        let yCenterConstraint = NSLayoutConstraint(item: self,
                                                   attribute: .centerY,
                                                   relatedBy: .equal,
                                                   toItem: activityIndicator,
                                                   attribute: .centerY,
                                                   multiplier: 1, constant: 0)
        self.addConstraint(yCenterConstraint)
    }
    
}
extension UIView{
 
    func showLoader(_ backgroundColor:UIColor? = nil ,_ activityColor : UIColor? = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)){
        
        let LoaderView  = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        LoaderView.tag = -1
        LoaderView.backgroundColor = backgroundColor
        let Loader = UIActivityIndicatorView(/*frame: CGRect(x: 0, y: 0, width: 60, height: 30)*/)
        Loader.center = LoaderView.center
       // Loader.style = .whiteLarge
        Loader.color = activityColor
        Loader.startAnimating()
        LoaderView.addSubview(Loader)
        self.addSubview(LoaderView)
    }

    func dismissLoader(){
        
        self.viewWithTag(-1)?.removeFromSuperview()
    }
}
