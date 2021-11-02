//
//  5.swift
//  TYOUT
//
//  Created by Mohamed Lotfy on 9/25/18.
//  Copyright © 2018 Gra7. All rights reserved.
//

import UIKit
import Kingfisher
import AudioToolbox
import NVActivityIndicatorView
import SwiftEntryKit
import SwiftMessages

extension UIViewController : UIGestureRecognizerDelegate{
    
    @IBAction func backClicked(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    @IBAction func backToRootClicked(_ sender: Any) {
        _ = self.navigationController?.popToRootViewController(animated: true)
    }
    
    
    @IBAction func dismissClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func dismissToRootClicked(_ sender: Any) {
        self.view.window!.rootViewController?.dismiss(animated: true)
    }
    
    func showMessage(title: String? = nil, sub: String?, type: Theme = .warning, layout: MessageView.Layout = .cardView) {
        
        let view = MessageView.viewFromNib(layout: .cardView)
        var config = SwiftMessages.Config()
        config.presentationContext = .window(windowLevel: .statusBar)
        view.configureTheme(backgroundColor: AppColor.MainDarkBlack.withAlphaComponent(0.92), foregroundColor: .white,iconImage: AppImages.Logo)
        view.configureContent(title: title ?? "", body: sub ?? "", iconText: "" )
        view.button?.isHidden = true
        
        view.iconImageView?.image = resizeImage(image: AppImages.Logo, targetSize:  CGSize.init(width: 60, height: 60))
        view.iconImageView?.contentMode = .scaleAspectFit
        view.iconImageView?.isHidden = false
        SwiftMessages.show(config: config, view: view)
    }
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    // MARK: - Show Alert
    func showAlertWith(title: String? = nil, msg: String? = nil, type: Theme = .warning, layout: MessageView.Layout = .messageView) {
        
        let view = MessageView.viewFromNib(layout: .messageView)
        var config = SwiftMessages.Config()
        config.presentationContext = .window(windowLevel: .statusBar)
        view.configureTheme(backgroundColor: UIColor.black.withAlphaComponent(0.92), foregroundColor: .white)
        view.configureContent(title: title ?? "", body: msg ?? "", iconText: "")
        view.button?.isHidden = true
        view.bodyLabel?.font = UIFont.init(name: Constants.AppFont.regular.rawValue, size: 17.0)
        
        SwiftMessages.show(config: config, view: view)
        
    }
    func addPopGesture() {
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    func alert(msg:String) {
        let alert = UIAlertController(title: "", message: msg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    func isNotEmptyString(text: String, withAlertMessage message: String) -> Bool{
        if text == ""{
            
            showMessage(title: "Empty Field".localized, sub: message, type: .error, layout: .statusLine)
            return false
        }
        else{
            return true
        }
    }
    
    // MARK: - Check Confirmation
    func isTextsIdentical(text1: String, text2: String, withAlertMessage message: String? = nil) -> Bool{
        if text1 == text2 {
            return true
        }else {
            if let errorMsg = message {
                showMessage(title: "Error Confirmation".localized, sub: message, type: .error, layout: .statusLine)
            }
            return false
        }
    }
    
    // MARK: - Email And Phone Validation
    func isEmailValid(emailString: String) -> Bool{
        let message = Messages()
        let regExPattern = "^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", argumentArray: [regExPattern])
        if !emailTest.evaluate(with: emailString){
            showMessage(sub: message.emailMessage)
        }
        return emailTest.evaluate(with: emailString)
    }
    
    func isPhoneNumberValid(phoneNumber: String) -> Bool{
        var isValid = true
        let nameValidation = phoneNumber.replacingOccurrences(of: " ", with: "")
        
        if (nameValidation.count < 7 || nameValidation.count > 14) { //check length limitation
            isValid = false
        }
        
        if !isValid{
            showMessage(sub: "Please, Insert Phone Number Correctly".localized)
        }
        
        return isValid
    }
    
    
    func alertSkipLogin(){
        let alert = UIAlertController.init(title: "Warning".localized , message: "please login first".localized ,  preferredStyle: .alert)
        alert.view.tintColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        
        
        
        let cancelAction = UIAlertAction.init(title: "Ok".localized, style: .cancel, handler: { (nil) in
            
            
            
        })
        
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    func setShadow(view : UIView , width : Int , height: Int , shadowRadius: CGFloat , shadowOpacity: Float , shadowColor: CGColor){
        // to make the shadow with rounded corners and offset shadow form the bottom
        view.layer.shadowColor = shadowColor
        view.layer.shadowOffset = CGSize(width: width, height: height)
        view.layer.shadowRadius = shadowRadius
        view.layer.shadowOpacity = shadowOpacity
        view.clipsToBounds = true
        view.layer.masksToBounds = false
    }
    enum Vibration {
        case error
        case success
        case warning
        case light
        case medium
        case heavy
        case selection
        case oldSchool
        func vibrate() {
            
            switch self {
            case .error:
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.error)
                
            case .success:
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.success)
                
            case .warning:
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.warning)
                
            case .light:
                let generator = UIImpactFeedbackGenerator(style: .light)
                generator.impactOccurred()
                
            case .medium:
                let generator = UIImpactFeedbackGenerator(style: .medium)
                generator.impactOccurred()
                
            case .heavy:
                let generator = UIImpactFeedbackGenerator(style: .heavy)
                generator.impactOccurred()
                
            case .selection:
                let generator = UISelectionFeedbackGenerator()
                generator.selectionChanged()
                
            case .oldSchool:
                AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            }
            
        }
        
    }
    
    
    //    // MARK: - Change Language
    //    func changeLanguage(to language: Constants.Language, storyBoard: Constants.StoryBoardName, vcId: Constants.StoryBoardVCIDs) {
    //         if language.rawValue == Constants.Language.arabic.rawValue {
    //            LocalizerLanguage.setLanguage(to: language.rawValue)
    //            UIView.appearance().semanticContentAttribute = .forceRightToLeft
    //        } else {
    //            LocalizerLanguage.setLanguage(to: language.rawValue)
    //            UIView.appearance().semanticContentAttribute = .forceLeftToRight
    //        }
    //
    //        let storyBoard: UIStoryboard = UIStoryboard.init(name: storyBoard.rawValue, bundle: nil)
    //
    //
    //        var rootviewcontroller = UIWindow()
    //
    //        if #available(iOS 13.0, *) {
    //            if let window = sceneDelegate.window {
    //                rootviewcontroller = window
    //            }
    //        } else {
    //            if let window = appDelegate.window {
    //                rootviewcontroller = window
    //            }
    //        }
    //
    //        rootviewcontroller.rootViewController = storyBoard.instantiateViewController(withIdentifier: vcId.rawValue)
    //        rootviewcontroller.backgroundColor = UIColor(hue: 0.6477, saturation: 0.6314, brightness: 0.6077, alpha: 0.8)
    //        UIView.transition(with: rootviewcontroller, duration: 0.55001, options: .transitionCrossDissolve, animations: { () -> Void in
    //        }) { (finished) -> Void in
    //
    //        }
    //    }
    
    
    
    
    
}
extension UIScreen {
    var minEdge: CGFloat {
        return UIScreen.main.bounds.minEdge
    }
}
extension CGRect {
    var minEdge: CGFloat {
        return min(width, height)
    }
}
extension String {
    func toDouble() -> Double? {
        return NumberFormatter().number(from: self)?.doubleValue
    }
}
extension UICollectionView {
    func reloadAnimation() {
        self.reloadData()
        self.layoutIfNeeded()
        
        let cells = self.visibleCells
        
        let tableViewHeight = self.bounds.size.height
        
        for (index,cell) in cells.enumerated() {
            
            if (index + 1 + index + 2 + index + 3 + 1 ) == 9 {
                cell.transform = CGAffineTransform(translationX:  -tableViewHeight * 0.5, y: tableViewHeight)
            } else {
                cell.transform = CGAffineTransform(translationX: tableViewHeight * 1.5, y: -tableViewHeight)
            }
        }
        var delayCounter = 0
        for cell in cells{
            UIView.animate(withDuration: 1.75, delay: Double(delayCounter) * 0.05, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                cell.transform = CGAffineTransform.identity
            }, completion: nil)
            delayCounter += 1
            
        }
    }
    
    
    
    func reloadAnimationSecond(){
        
        switch Int(arc4random_uniform(3)) {
        case 0:
            animateTable0()
            break
        case 1:
            animateTable1()
            break
        case 2 :
            animateTable2()
            break
            
        default:
            break
        }
        
    }
    
    func animateTable0(){
        self.reloadData()
        let cells = self.visibleCells
        let tableViewHeight = self.bounds.size.height
        for cell in cells{
            cell.transform = CGAffineTransform(translationX: 0, y: tableViewHeight)
        }
        var delayCounter = 0
        for cell in cells{
            
            UIView.animate(withDuration: 1.75, delay: Double(delayCounter) * 0.05, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                cell.transform = CGAffineTransform.identity
            }, completion: nil)
            delayCounter += 1
            
        }
        
    }
    func animateTable1(){
        self.reloadData()
        let cells = self.visibleCells
        let tableViewHeight = self.bounds.size.height
        
        for (index, cell) in cells.enumerated() {
            if index % 2 == 0 {
                cell.transform = CGAffineTransform(translationX: 1000, y: tableViewHeight)
            } else {
                cell.transform = CGAffineTransform(translationX: -1000, y: tableViewHeight)
            }
        }
        var delayCounter = 0
        for cell in cells{
            
            UIView.animate(withDuration: 1.75, delay: Double(delayCounter) * 0.05, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                cell.transform = CGAffineTransform.identity
            }, completion: nil)
            delayCounter += 1
        }
    }
    
    
    func animateTable2(){
        self.reloadData()
        let cells = self.visibleCells
        let tableViewHeight = self.bounds.size.height
        for cell in cells{
            cell.transform = CGAffineTransform(translationX: -1000, y: tableViewHeight)
        }
        var delayCounter = 0
        for cell in cells{
            
            UIView.animate(withDuration: 1.75, delay: Double(delayCounter) * 0.05, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                cell.transform = CGAffineTransform.identity
            }, completion: nil)
            delayCounter += 1
            
        }
    }
    
    
}

extension UIImageView{
    func loadImageUrl(_ image : String?) {
        let urlString = image?.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
        
        let url = URL(string: image ?? "https://estqbalat.vygit.com/storage/photos/shares/5e6788ae8d679.png")
        
        self.kf.indicatorType = .activity
        self.kf.setImage(with: url)
    }
}
extension UIView{
    func setNoDataLabel(text: String, frameRect: CGRect = CGRect.zero, withBackgroundColor backgroundColor: UIColor =  UIColor(white: 0.0, alpha: 0.2), textColor: UIColor = UIColor.black , typeFlag : String ){//table , collection
        let containerView = UIView()
        let label = UILabel()
        
        if frameRect == CGRect.zero{
            containerView.frame = bounds
        }
        else{
            containerView.frame = frameRect
        }
        containerView.tag = 10000
        containerView.backgroundColor = self.backgroundColor
        
        label.frame = containerView.bounds
        label.frame.size.width =  containerView.frame.size.width
        label.numberOfLines = 0
        label.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        label.text = text
        if typeFlag == "collection" {
            label.transform = CGAffineTransform(scaleX: -1, y: 1)
            
        }
        containerView.addSubview(label)
        
        addSubview(containerView)
    }
    
    func removeNoDataLabel(tag: Int = 10000){
        if let noDataLabel = self.viewWithTag(tag) {
            UIView.animate(withDuration: 0.2, animations: {
                noDataLabel.alpha = 0.0
            }) { finished in
                noDataLabel.removeFromSuperview()
            }
        }
    }
    func lock(frameRect: CGRect = CGRect.zero, color: UIColor? = .white) {
        if (viewWithTag(10) != nil) {
            //View is already locked
        }
        else {
            let lockView = UIView()
            
            if frameRect == CGRect.zero{
                lockView.frame = bounds
            }
            else{
                lockView.frame = frameRect
            }
            
            lockView.backgroundColor = UIColor(white: 0.5, alpha: 0.3)
            
            lockView.tag = 10
            lockView.alpha = 0.0
            
            let activityIndicator = UIActivityIndicatorView.init(frame: CGRect(x: lockView.center.x, y: lockView.center.y, width: 50, height: 50))
            
            activityIndicator.center.x = lockView.center.x
            activityIndicator.center.y = lockView.center.y
            activityIndicator.color = .black
            
            activityIndicator.startAnimating()
            
            lockView.addSubview(activityIndicator)
            addSubview(lockView)
            
            UIView.animate(withDuration: 0.2) {
                lockView.alpha = 1.0
            }
        }
    }
    
    func unlock() {
        if let lockView = self.viewWithTag(10) {
            UIView.animate(withDuration: 0.2, animations: {
                lockView.alpha = 0.0
            }) { finished in
                lockView.removeFromSuperview()
            }
        }
    }
}
