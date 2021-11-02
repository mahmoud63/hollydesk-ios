//
//  LoginViewController.swift
//  HollyDesk
//
//  Created by rania refaat on 03/07/2021.
//

import UIKit
import SSSpinnerButton

class LoginViewController: UIViewController {

    //MARK:- outlets
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var loginButton: SSSpinnerButton!
    @IBOutlet weak var forgetPasswordButton: UIButton!

    //MARK:- variables
    let message = Messages()
    var language = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        setTextField()
        forgetPasswordButton.underlineText()
    }
    private func setTextField(){
        textPadding(tf: emailTF)
        textPadding(tf: passwordTF)
    }
    @IBAction func loginSelected(_ sender: UIButton) {
        
        if isNotEmptyString(text: self.emailTF.text!, withAlertMessage: message.emailMessage) && isNotEmptyString(text: self.passwordTF.text!, withAlertMessage: message.passwordMessage){

//                let mobileToken = UserDefaultData.get_user_string_data(key: UserDefaultDataKeys.deviceToken) ?? "token"
                let params = ["email":self.emailTF.text!,
                              "password":self.passwordTF.text!,
                              "deviceToken": "deviceToken"
                              ]as[String:AnyObject]
                Login(parameters: params)
            
        }
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
    @IBAction func ForgetButtonTapped(_ sender: UIButton) {

    }
}
extension LoginViewController{
    func Login(parameters : [String:AnyObject]) {
        DispatchQueue.main.async {
            
            self.view.isUserInteractionEnabled = false
            self.loginButton.startAnimate(spinnerType: .circleStrokeSpin, spinnercolor: .white, spinnerSize: 20, complete: nil)
            
            let manager = Manager()
            
            manager.perform(UserModel.self, serviceName: .login, method: .post, parameters: parameters) {[weak self] (result) in
                guard let self = self else {return}
                switch result {
                case .success(let model):
                    if model.data == nil{
                        self.responseFaile(message: model.message ?? "")
                    }else{
                        self.loginButton.stopAnimationWithCompletionTypeAndBackToDefaults(
                            completionType: .success,
                            backToDefaults: true,
                            complete: {
                                let usrData = model.data!
                                UserDefaultData.save_user_data(loginModel: usrData)
                                UserDefaultData.setIsRegister(registered: true)
                                sceneDelegate.setRoot()
                            })
                    }
                    break
                case .failure(let err):
                    self.responseFaile(message: err!.localizedDescription)
                case .noConnection(let Message):
                    self.responseFaile(message: self.message.noConnectionMessage)
                }
            }
            self.view.isUserInteractionEnabled = true

        }
    }
    func responseFaile(message : String){
        self.loginButton.stopAnimationWithCompletionTypeAndBackToDefaults(completionType: .error, backToDefaults: true, complete: nil)
        self.showMessage(sub: message)
        
    }
}
