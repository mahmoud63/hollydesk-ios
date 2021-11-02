//
//  Constants.swift
//  Aleary-ios
//
//  Created by Mohamed Lotfy on 8/25/20.
//  Copyright © 2020 panorama. All rights reserved.
//

import UIKit

struct Constants {
    
    static var shared = Constants()
    
    static let appleLanguageKey = "AppleLanguages"
    
    enum AppFont: String {
        case bold = "Dubai-Bold"
        case light = "Dubai-Light"
        case regular = "Dubai-Regular"
        case semiBold = "Dubai-Medium"
    }
    
    // MARK: - Application Languages
    enum Language: String {
        case arabic = "ar"
        case english = "en"
    }  
}


func delay(_ seconds: Double, completion: @escaping () -> ()) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
        completion()
    }
}






