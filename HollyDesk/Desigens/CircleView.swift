//
//  CircleView.swift
//  Detailes
//
//  Created by MacBook on 12/28/19.
//  Copyright © 2019 Rania. All rights reserved.
//

import Foundation
import UIKit

class CircleView: UIView {
    @IBInspectable var CircleHeight : CGFloat = 2 {
        didSet{
            self.layer.masksToBounds = false
            self.layer.cornerRadius = self.frame.height/CircleHeight
            self.clipsToBounds = true
            
        }
    }
    @IBInspectable var cornerColor : UIColor = UIColor.black   {
        didSet{
            self.layer.masksToBounds = false
            self.layer.borderWidth = 0.0
            self.layer.borderColor = cornerColor.cgColor
            self.clipsToBounds = true
        }
    }
}
class CircleImageView : UIImageView {
    @IBInspectable var CircleHeight : CGFloat = 2 {
        didSet{
            self.layer.cornerRadius = self.frame.height/CircleHeight
            self.clipsToBounds = true
            
        }
    }
    @IBInspectable var cornerColor : UIColor = UIColor.black   {
        didSet{
            self.layer.masksToBounds = false
            self.layer.borderWidth = 0.5
            self.layer.borderColor = cornerColor.cgColor
            self.clipsToBounds = true
        }
    }
    

}
class CircleButton : UIButton {
    @IBInspectable var CircleHeight : CGFloat = 2 {
        didSet{
            self.layer.borderWidth = 1
            self.layer.masksToBounds = false
            self.layer.borderColor = UIColor.clear.cgColor
            self.layer.cornerRadius = self.frame.height/CircleHeight
            self.clipsToBounds = true
            
        }
    }
}
