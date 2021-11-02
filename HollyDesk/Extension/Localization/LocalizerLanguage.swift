////
////  LocalizerLanguage.swift
////  Localizer
////
////  Created by Mohamed Tarek on 7/19/19.
////  Copyright © 2019 Mohamed Tarek. All rights reserved.
////
//
//import UIKit
//
///// LocalizerLanguage
//class LocalizerLanguage {
//    
//    /// get current language
//    class func currentLanguage() -> String {
//        let userdef = UserDefaults.standard
//        let langArray = userdef.object(forKey: Constants.appleLanguageKey) as! NSArray
//        let current = langArray.firstObject as! String
//        let endIndex = current.startIndex
//        let index = current.index(endIndex, offsetBy: 2)
//        let currentWithoutLocale = current.prefix(upTo: index)
//        return "\(currentWithoutLocale)"
//    }
//    
//    class func currentAppleLanguageFull() -> String{
//        let userdef = UserDefaults.standard
//        let langArray = userdef.object(forKey: Constants.appleLanguageKey) as! NSArray
//        let current = langArray.firstObject as! String
//        return current
//    }
//    
//    /// set @lang to be the first in Languages list
//    class func setLanguage(to lang: Constants.Language) {
//        let userdef = UserDefaults.standard
//        userdef.set([lang.rawValue ,currentLanguage()], forKey: Constants.appleLanguageKey)
//        userdef.synchronize()
//    }
//    
//    class var isRTL: Bool {
//        return LocalizerLanguage.currentLanguage() == "ar"
//    }
//    
//}
