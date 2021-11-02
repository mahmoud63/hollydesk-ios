//
//  2.swift
//  TYOUT
//
//  Created by Mohamed Lotfy on 9/25/18.
//  Copyright © 2018 Gra7. All rights reserved.
//

import UIKit

extension UINavigationController {
    var rootViewController : UIViewController? {
        return self.viewControllers.first
    }
}


extension UIApplication {
    
    class func topViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        
        return base
    }
    
    
    class func tryURL(urls: [String]) {
        let application = UIApplication.shared
        for url in urls {
            if application.canOpenURL(URL(string: url)!) {
                //                application.openURL(URL(string: url)!)
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(URL(string: url)!, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(URL(string: url)!)
                }
                
                return
            }
        }
    }
}
