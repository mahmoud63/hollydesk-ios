//
//  ManagerTabBarManager.swift
//  HollyDesk
//
//  Created by rania refaat on 30/09/2021.
//

import UIKit
import SideMenu

class ManagerTabBarManager: UITabBarController {

    var screenTitle = ScreenTitle()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeViewController = makeNavRoot(vc: HomeViewController())
                        
        let claimsViewController = makeNavRoot(vc: ClaimViewController())

        let walletViewController = makeNavRoot(vc: WalletViewController())

        let teamViewController = makeNavRoot(vc: ManagerRequestsTypeViewController())

        homeViewController.tabBarItem = setupTabBar(title: screenTitle.home, image: AppImages.home, selectedImage: AppImages.home)

        claimsViewController.tabBarItem = setupTabBar(title: screenTitle.myRequests, image: AppImages.claim, selectedImage: AppImages.claim)

        walletViewController.tabBarItem = setupTabBar(title: screenTitle.wallet, image: AppImages.wallet, selectedImage: AppImages.wallet)

        
        teamViewController.tabBarItem = setupTabBar(title: screenTitle.teamTab, image: AppImages.more, selectedImage: AppImages.more)

        viewControllers = [homeViewController , claimsViewController , teamViewController , walletViewController]
        
        self.tabBar.tintColor = AppColor.MainDarkGreen
        self.tabBar.barTintColor = AppColor.MainWhite
        self.tabBar.unselectedItemTintColor = AppColor.MainBlack
        
    }
    private func makeNavRoot(vc: UIViewController)->SideMenuNavigationController{
        return SideMenuNavigationController(rootViewController: vc)
    }
    private func setupTabBar(title: String , image: UIImage , selectedImage: UIImage)->UITabBarItem{
        return UITabBarItem(title: title, image: image, selectedImage:  selectedImage)
    }
}
