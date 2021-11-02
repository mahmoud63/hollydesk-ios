//
//  SceneDelegate.swift
//  HollyDesk
//
//  Created by rania refaat on 03/07/2021.
//

import UIKit
import IQKeyboardManagerSwift

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        setRoot()
        initIQKeyboardManager()
        HandelNavigationStyle()
        L102Localizer.DoTheMagic()
        
        if let userActivity = connectionOptions.userActivities.first {
          self.scene(scene, continue: userActivity)
        } else {
          self.scene(scene, openURLContexts: connectionOptions.urlContexts)
        }
//        https://www.dev.hollydesk.com/createPass?id=60d2716bb4c223e0573b1ded&type=createPassword
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            print(url)
        }
        for context in URLContexts {
          print("url: \(context.url.absoluteURL)")
          print("scheme: \(context.url.scheme)")
          print("host: \(context.url.host)")
          print("path: \(context.url.path)")
          print("components: \(context.url.pathComponents)")
        }
    }
    func open(_ url: URL,
      options: [UIApplication.OpenExternalURLOptionsKey : Any] = [:],
      completionHandler completion: ((Bool) -> Void)? = nil){
        
    }
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return true
    }
    func canOpenURL(_ url: URL) -> Bool
    {
        return true
    }
    func scene(_ scene: UIScene, continue userActivity: NSUserActivity) {
        if let url = userActivity.webpageURL {
            // ...
        }
        print(userActivity.webpageURL)
    }
}

extension SceneDelegate{
    func setRoot(){
        let isRegistered = UserDefaultData.isRegistered()
        let userType = UserDefaultData.getUserType()
        
        if isRegistered {
            switch userType {
            case .user:
                window?.rootViewController = TabBarManager()
            case .employee:
                window?.rootViewController = ManagerTabBarManager()
            default:
                window?.rootViewController = LoginViewController()
            }
        }else{
            window?.rootViewController = LoginViewController()
        }
    }
}
// MARK: - Initialize IQKeyboard
extension SceneDelegate {
    func initIQKeyboardManager() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.toolbarTintColor = .white
        IQKeyboardManager.shared.toolbarBarTintColor = AppColor.MainDarkGreen
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.shouldShowToolbarPlaceholder = false
    }
}
extension SceneDelegate {
    func HandelNavigationStyle(){
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear], for: .normal)
        
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear], for: UIControl.State.highlighted)
        
        UIBarButtonItem.appearance().tintColor = AppColor.MainBlack
        
    }
}
