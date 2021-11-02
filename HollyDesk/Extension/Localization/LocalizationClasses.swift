////
////  LocalizationClasses.swift
////
////
////  Created by Mohamed Tarek on 2/17/20.
////  Copyright © 2020 Mohamed Tarek. All rights reserved.
////
//
//import Foundation
//import UIKit
//
//class LocalizedBarButtonItem: UIBarButtonItem {
//    
//    required init?(coder: NSCoder) { super.init() }
//    
//    @IBInspectable
//     var localizedImage: UIImage {
//        didSet {
//            if LocalizerLanguage.isRTL {
//                self.image = self.localizedImage
//            }
//        }
//    }
//    
//}
//
//class LocalizedButton: UIButton {
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        if LocalizerLanguage.isRTL {
//            self.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
//        }
//    }
//}
//
//class LocalizedImageView: UIImageView {
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        if LocalizerLanguage.isRTL {
//            self.transform = CGAffineTransform.init(scaleX: -1.0, y: 1.0)
//        }
//    }
//}
//
