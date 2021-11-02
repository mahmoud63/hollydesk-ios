//
//  sideMenue.swift
//  HollyDesk
//
//  Created by rania refaat on 10/07/2021.
//

import Foundation
import SideMenu

extension UIViewController{
    
    func sideNavigation(){
        let sideButton = UIBarButtonItem(image: AppImages.more, style: .plain, target: self, action: #selector(sideFunc))
        navigationItem.leftBarButtonItem =  sideButton
    }
    @objc func sideFunc(){
        print("sideFunc")
        let leftMenuNavigationController = SideMenuNavigationController(rootViewController: SideMenuViewController())
        SideMenuManager.default.leftMenuNavigationController = leftMenuNavigationController

        let rightMenuNavigationController = SideMenuNavigationController(rootViewController: SideMenuViewController())
        SideMenuManager.default.rightMenuNavigationController = rightMenuNavigationController

        SideMenuManager.default.addPanGestureToPresent(toView: self.navigationController!.navigationBar)
        SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)

        leftMenuNavigationController.statusBarEndAlpha = 0
        rightMenuNavigationController.settings = leftMenuNavigationController.settings
        
        rightMenuNavigationController.presentationStyle = .menuSlideIn
        leftMenuNavigationController.presentationStyle = .menuSlideIn


       if L102Language.isRTL {
        present(rightMenuNavigationController, animated: true, completion: nil)
       }else{
        present(leftMenuNavigationController, animated: true, completion: nil)

       }
    }
    
}
