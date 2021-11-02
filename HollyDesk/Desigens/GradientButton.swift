//
//  GradientButton.swift
//  TonBike-ios
//
//  Created by apple on 4/27/20.
//  Copyright © 2020 panorama. All rights reserved.
//

import UIKit
class StyleGradiantCorner : StyleButton {
    var gradientLayer:CAGradientLayer = CAGradientLayer()
    override func applyStyle() {
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.layer.frame.height / 2
        
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [ #colorLiteral(red: 0.8862745098, green: 0.5803921569, blue: 0.231372549, alpha: 1) , #colorLiteral(red: 0.9607843137, green: 0.4470588235, blue: 0.2274509804, alpha: 1)].map { $0.cgColor }
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        //gradientLayer.locations = [0.0 , 1.0]
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
      override func layoutSubviews() {
     super.layoutSubviews()
     gradientLayer.frame = self.bounds
     layoutIfNeeded()
     }
}
class StyleButton: UIButton {
    func applyStyle() {
        self.layer.cornerRadius = self.layer.frame.height / 2
        self.clipsToBounds = true
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        applyStyle()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        applyStyle()
    }
}
