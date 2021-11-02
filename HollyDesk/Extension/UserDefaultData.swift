//
//  UserDefaultData.swift
//  Detailes
//
//  Created by MacBook on 12/28/19.
//  Copyright © 2019 Rania. All rights reserved.
//

import UIKit
//import RealmSwift

class UserDefaultData: NSObject {
    
    class func save_user_data(loginModel: UserModelData){
        let def = UserDefaults.standard
        let firstName = loginModel.user?.firstName
        let lastName = loginModel.user?.lastName

        let fullName = "\(firstName ?? "") \(lastName ?? "")"
        def.set(firstName, forKey: UserDefaultDataKeys.firstName)
        def.set(lastName, forKey: UserDefaultDataKeys.lastName)
        def.set(loginModel.user?.email, forKey: UserDefaultDataKeys.userEmail)
        def.set(loginModel.token ?? "", forKey: UserDefaultDataKeys.userToken)
        def.set(fullName, forKey: UserDefaultDataKeys.fullName)
        def.set(loginModel.user?.credit, forKey: UserDefaultDataKeys.credit)
        def.set(loginModel.user?.role, forKey: UserDefaultDataKeys.userType)
        def.set(loginModel.user?.jobTitle, forKey: UserDefaultDataKeys.jobTitle)
        def.set(loginModel.user?.image, forKey: UserDefaultDataKeys.userImage)
        def.set(loginModel.user?.team?.name, forKey: UserDefaultDataKeys.team)
        def.set(loginModel.user?.role, forKey: UserDefaultDataKeys.role)

        def.synchronize()
    }
    class func save_user_profile_data(loginModel: UserProfileModelData){
        let def = UserDefaults.standard
        let firstName = loginModel.firstName
        let lastName = loginModel.lastName

        let fullName = "\(firstName ?? "") \(lastName ?? "")"
        def.set(firstName, forKey: UserDefaultDataKeys.firstName)
        def.set(lastName, forKey: UserDefaultDataKeys.lastName)
        def.set(loginModel.email, forKey: UserDefaultDataKeys.userEmail)
        def.set(loginModel.token ?? "", forKey: UserDefaultDataKeys.userToken)
        def.set(fullName, forKey: UserDefaultDataKeys.fullName)
        def.set(loginModel.credit, forKey: UserDefaultDataKeys.credit)
        def.set(loginModel.role, forKey: UserDefaultDataKeys.userType)
        def.set(loginModel.jobTitle, forKey: UserDefaultDataKeys.jobTitle)
        def.set(loginModel.image, forKey: UserDefaultDataKeys.userImage)
        def.set(loginModel.team?.name, forKey: UserDefaultDataKeys.team)
        def.set(loginModel.role, forKey: UserDefaultDataKeys.role)

        def.synchronize()
    }
//
    ///handel save & get user data string
    class func save_user_string_data(key: String , value : String) {
        let def = UserDefaults.standard
        def.set(value, forKey: "\(key)")
        def.synchronize()
    }
    class func get_user_string_data(key: String)->String? {
        let def = UserDefaults.standard
        return def.object(forKey: key) as? String
    }

    ///handel save & get user data Int
    class func save_user_int_data(key: String , value : Int) {
        let def = UserDefaults.standard
        def.set(value, forKey: "\(key)")
        def.synchronize()
    }
    class func get_user_int_data(key: String)->Int? {
        let def = UserDefaults.standard
        return def.object(forKey: key) as? Int
    }
    
    ///handel save & get user data Int
    class func save_user_double_data(key: String , value : Double) {
        let def = UserDefaults.standard
        def.set(value, forKey: "\(key)")
        def.synchronize()
    }
    class func get_user_double_data(key: String)->Double? {
        let def = UserDefaults.standard
        return def.object(forKey: key) as? Double
    }
    
    class func save_user_bool_data(key: String , value : Bool){
        let def = UserDefaults.standard
        def.set(value, forKey: "\(key)")
        def.synchronize()
    }
    
    class func isRegistered() -> Bool{
        let defaults = UserDefaults.standard
        return defaults.bool(forKey: UserDefaultDataKeys.IsRegistered)
    }
    
    
    class func setIsRegister(registered: Bool){
        let defaults = UserDefaults.standard
        defaults.set(registered, forKey: UserDefaultDataKeys.IsRegistered)
    }
    
    
    class func Delete_User_Data(){
        //        let realm = try! Realm()
        
        let def = UserDefaults.standard
        def.removeObject(forKey: UserDefaultDataKeys.userToken)
        def.removeObject(forKey: UserDefaultDataKeys.firstName)
        def.removeObject(forKey: UserDefaultDataKeys.lastName)
        def.removeObject(forKey: UserDefaultDataKeys.userEmail)
        
        def.removeObject(forKey: UserDefaultDataKeys.IsRegistered)
        def.removeObject(forKey: UserDefaultDataKeys.fcm_token_android)
        def.removeObject(forKey: UserDefaultDataKeys.fcm_token_ios)
        def.removeObject(forKey: UserDefaultDataKeys.mobileToken)
        def.removeObject(forKey: UserDefaultDataKeys.fullName)
        def.removeObject(forKey: UserDefaultDataKeys.credit)
        def.removeObject(forKey: UserDefaultDataKeys.userType)
        def.removeObject(forKey: UserDefaultDataKeys.jobTitle)
        def.removeObject(forKey: UserDefaultDataKeys.userImage)
        def.removeObject(forKey: UserDefaultDataKeys.team)

    }
    
   class func getUserType()->UserType{
        let def = UserDefaults.standard
        guard let type = def.object(forKey: UserDefaultDataKeys.userType) as? String else {return .non}
        if type == "user" {
            return .user
        }
        return .employee
    }
    
}
enum UserType{
    case employee
    case user
    case non
}
struct UserDefaultDataKeys {
    
    static let userToken = "userToken"
    static let firstName = "firstName"
    static let lastName = "lastName"
    static let userEmail = "userEmail"
    static let fullName = "fullName"
    static let credit = "credit"

    static let IsRegistered = "IsRegistered"
    static let fcm_token_android = "fcm_token_android"
    static let fcm_token_ios = "fcm_token_ios"
    static let mobileToken = "mobileToken"
    static let appLanguage = "appLanguage"
    
    static let userType = "userType"
    static let jobTitle = "jobTitle"
    static let userImage = "userImage"
    static let team = "team"
    static let role = "role"



}

class Language {
    class func currentLanguage() -> String {
        let def = UserDefaults.standard
        let langs = def.object(forKey: "AppleLanguages") as! NSArray
        let firstLang = langs.firstObject as! String
        return firstLang
    }
    
    class func setAppLanguage(lang: String) {
        let def = UserDefaults.standard
        def.removeObject(forKey: "AppleLanguages")
        def.set([lang], forKey: "AppleLanguages")
        def.synchronize()
    }
    
    class func isEnglish()->Bool {
        if currentLanguage() == "en" || currentLanguage() == "en-US"{
            return true
        }else{
            return false
        }
    }
    
}

let appDelegate = UIApplication.shared.delegate as! AppDelegate
@available(iOS 13.0, *)
let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate

