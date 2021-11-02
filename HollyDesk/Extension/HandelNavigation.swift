//
//  NavigationDesigen.swift
//  Detailes
//
//  Created by MacBook on 12/28/19.
//  Copyright © 2019 Rania. All rights reserved.
//

import Foundation
import UIKit
import ViewAnimator

extension UIViewController {
    
    // MARK: - Transparent With Nav Bar
    func transparentNavBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
    
    func setTitleImage(name:String){
        let logo = UIImage(named: name)
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
    }
    
    func setNavImage(image:UIImage){
        
        let imageView = UIImageView(image:image)
        imageView.contentMode = .scaleAspectFit
        self.navigationController?.navigationBar.setBackgroundImage(imageView.image?.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch), for: .default)

        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.view.backgroundColor = .clear
        
//        navigationController?.navigationBar.tintColor = AppColor.White
//        navigationController?.navigationBar.barTintColor = AppColor.Clear
//        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: AppColor.White]

    }
    
    // MARK: - Transparent With Nav Bar
    func notTransparentNavBar() {
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
    }

    func giveNavigationStyle(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0, green: 0.4662680626, blue: 0.2695541978, alpha: 1)
        self.navigationController?.navigationBar.isTranslucent = true
    }
    func removeNavigationStyle(){
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationController?.navigationBar.shadowImage = nil
        self.navigationController?.navigationBar.isTranslucent = false
    }
    func HideNavigationBar(status: Bool){
        
        navigationController?.setNavigationBarHidden(status, animated: true)
    }
    func HideTabBar(status: Bool){
        
        tabBarController?.tabBar.isHidden = status
    }

    func HandelNavigationTintColor(status: Bool){
        
        if status {
            //colored
            self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.9607843137, green: 0.4470588235, blue: 0.2274509804, alpha: 1)
            
            self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Cairo-SemiBold", size: 18)! , NSAttributedString.Key.foregroundColor:  #colorLiteral(red: 0.9607843137, green: 0.4470588235, blue: 0.2274509804, alpha: 1)]

        }else{
            
            self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            
            self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Cairo-SemiBold", size: 18)! , NSAttributedString.Key.foregroundColor: UIColor.white]

        }

    }
/// true : white
    func NavigationTintColor(status : Bool){
//        if status {
//            self.navigationController?.navigationBar.tintColor = AppColor.White
//
//        }else{
//            self.navigationController?.navigationBar.tintColor = AppColor.DarkBrowen
//
//        }

    }

    func addDownSwipe(){
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeDown.direction = UISwipeGestureRecognizer.Direction.down
        self.view.addGestureRecognizer(swipeDown)
    }
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.right:
                print("Swiped right")
            case UISwipeGestureRecognizer.Direction.down:
                print("Swiped down")
                let transition = CATransition()
                transition.duration = 0.2
                //        transition.type = CATransitionType.push
                transition.subtype = CATransitionSubtype.fromBottom
                view.window!.layer.add(transition, forKey: kCATransition)
                self.dismiss(animated: false)
            case UISwipeGestureRecognizer.Direction.left:
                print("Swiped left")
            case UISwipeGestureRecognizer.Direction.up:
                print("Swiped up")
            default:
                break
            }
        }
    }
    func dismissFromBottom(){
        let transition = CATransition()
        transition.duration = 0.2
        //        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromBottom
        view.window!.layer.add(transition, forKey: kCATransition)
        self.dismiss(animated: false)
    }
    func presentFromBottom(VC: UIViewController){
        VC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        let transition = CATransition()
        transition.duration = 0.2
        transition.subtype = CATransitionSubtype.fromTop
        view.window!.layer.add(transition, forKey: kCATransition)
        present(VC, animated: true, completion: nil)
    }
    func tableDesign(tvc: UITableView){
        tvc.tableFooterView = UIView()
        tvc.separatorInset = .zero
        tvc.contentInset = .zero
    }
    func textPadding(tf: UITextField , padding: Double = 17){
        let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: padding, height: 0.0))
        tf.leftView = leftView
        tf.rightView = leftView
        tf.leftViewMode = .always
        tf.rightViewMode = .always
    }
    func dismissView(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func popView(){
        self.navigationController?.popViewController(animated: true)
    }
    func popToRootView(){
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func notificationNavigation(){
        let notificationBtn = UIBarButtonItem(image: AppImages.Logo, style: .plain, target: self, action: #selector(notificationFunc))
//        navigationController?.navigationBar.tintColor = AppColor.White
//        navigationController?.navigationBar.barTintColor = AppColor.DarkBrowen
//        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: AppColor.White]
        navigationItem.rightBarButtonItem =  notificationBtn
    }
    @objc func notificationFunc(){
//        let viewO = ViewObjects()
//        let vc = viewO.searchWordsVC
//        show(vc!, sender: nil)
        print("notificationFunc")
    }
    func backNavigation(){
//        navigationController?.navigationBar.tintColor = AppColor.DarkBrowen
//        navigationController?.navigationBar.barTintColor = AppColor.Clear
//        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: AppColor.DarkBrowen]

    }
    func cartNavigation(){
//        let cartBtn = UIBarButtonItem(image: AppImages.cart, style: .plain, target: self, action: #selector(cartFunc))
//        navigationController?.navigationBar.tintColor = AppColor.WhiteColor
//        navigationController?.navigationBar.tintColor = AppColor.WhiteColor
//        navigationController?.navigationBar.barTintColor = AppColor.BackGround
//        navigationItem.rightBarButtonItem =  cartBtn
    }
    @objc func cartFunc(){
//        let viewO = ViewObjects()
//        let vc = viewO.searchWordsVC
//        show(vc!, sender: nil)
        
    }
}//end of extension
