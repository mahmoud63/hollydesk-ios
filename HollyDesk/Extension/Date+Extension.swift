//
//  Date+Extension.swift
//  NewHomy
//
//  Created by haniielmalky on 10/13/19.
//  Copyright © 2019 com.Exception. All rights reserved.
//

import Foundation

extension Date {
    
    struct Date_ {
        static let formatter = DateFormatter()
    }
    
    var fullDateString: String {
        Date_.formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        Date_.formatter.locale = NSLocale(localeIdentifier: "en_US") as Locale?
        
        return Date_.formatter.string(from: self)
    }
    
    var dateString: String {
        Date_.formatter.dateFormat = "dd MMM yyyy"
        Date_.formatter.locale = NSLocale(localeIdentifier: "en_US") as Locale?
        
        return Date_.formatter.string(from: self)
    }
    
    var formatToSend: String {
           Date_.formatter.dateFormat = "yyyy-MM-dd"
           Date_.formatter.locale = NSLocale(localeIdentifier: "en_US") as Locale?
           
           return Date_.formatter.string(from: self)
    }
    
    var timeString: String {
           Date_.formatter.dateFormat = "HH:mm"
           Date_.formatter.locale = NSLocale(localeIdentifier: "en_US") as Locale?
           
           return Date_.formatter.string(from: self)
    }
}
