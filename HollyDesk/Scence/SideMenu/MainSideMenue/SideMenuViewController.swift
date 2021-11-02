//
//  SideMenuViewController.swift
//  HollyDesk
//
//  Created by rania refaat on 11/07/2021.
//

import UIKit

class SideMenuViewController: UIViewController {
    
    var language = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        HideNavigationBar(status: true)
    }
    @IBAction func logoutButtonTapped(_ sender: UIButton) {
        UserDefaultData.Delete_User_Data()
        UserDefaultData.setIsRegister(registered: false)
        sceneDelegate.setRoot()
    }
    @IBAction func englishButtonTapped(_ sender: UIButton) {
        if L102Language.isRTL {
            L102Language.setAppleLAnguageTo(lang: "en")
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
            sceneDelegate.setRoot()
        }
    }
    
    @IBAction func arabicButtonTapped(_ sender: UIButton) {
        if !L102Language.isRTL {
            L102Language.setAppleLAnguageTo(lang: "ar")
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
            sceneDelegate.setRoot()
        }
    }
    @IBAction func profileButtonTapped(_ sender: UIButton) {
        show(MyProfileViewController(), sender: self)
    }
}
