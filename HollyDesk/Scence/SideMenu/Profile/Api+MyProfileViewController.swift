//
//  Api+MyProfileViewController.swift
//  HollyDesk
//
//  Created by rania refaat on 03/10/2021.
//

import UIKit
extension MyProfileViewController{
    func updateProfile(parameters : [String:AnyObject]){
        let manager = Manager()
        self.view.isUserInteractionEnabled = false
        self.uploadButton.startAnimate(spinnerType: .circleStrokeSpin, spinnercolor: .white, spinnerSize: 20, complete: nil)

        if imageFlag{
            manager.performImages(UserProfileModel.self, serviceName: .profile, method: .post , image: userImageView.image, authenticationEnabled: true , imageName: "file", parameters: parameters) {[weak self] (result) in
                guard let self = self else {return}
                self.view.dismissLoader()
                switch result {
                case .success(let model):
                    if model.data == nil{
                        self.responseFail(message: model.message ?? "")
                    }else{
                        self.uploadButton.stopAnimationWithCompletionTypeAndBackToDefaults(
                            completionType: .success,
                            backToDefaults: true,
                            complete: {
                                var usrData = model.data!
                                let token = UserDefaultData.get_user_string_data(key: UserDefaultDataKeys.userToken) ?? ""
                                usrData.token = token
                                print(usrData)
                                UserDefaultData.save_user_profile_data(loginModel: usrData)
                                print(usrData)
                                UserDefaultData.setIsRegister(registered: true)
                                self.popView()
                            })
                    }
                    break
                case .failure(let err):
                    self.responseFail(message: err!.localizedDescription)
                case .noConnection:
                    self.responseFail(message: self.message.noConnectionMessage)
                }
            }
            self.view.isUserInteractionEnabled = true
        }else{
            manager.perform(UserProfileModel.self, serviceName: .profile, method: .post, authenticationEnabled: true, parameters: parameters) {[weak self] (result) in
                guard let self = self else {return}
                switch result {
                case .success(let model):
                    if model.data == nil{
                        self.responseFail(message: model.message ?? "")
                    }else{
                        self.uploadButton.stopAnimationWithCompletionTypeAndBackToDefaults(
                            completionType: .success,
                            backToDefaults: true,
                            complete: {
                                var usrData = model.data!
                                let token = UserDefaultData.get_user_string_data(key: UserDefaultDataKeys.userToken) ?? ""
                                usrData.token = token
                                print(usrData)
                                UserDefaultData.save_user_profile_data(loginModel: usrData)
                                print(usrData)
                                UserDefaultData.setIsRegister(registered: true)
                                self.popView()
                            })
                    }
                    break
                case .failure(let err):
                    self.responseFail(message: err!.localizedDescription)
                case .noConnection(let Message):
                    self.responseFail(message: self.message.noConnectionMessage)
                }
            }
            self.view.isUserInteractionEnabled = true
        }
    }
    func responseFail(message : String){
        self.uploadButton.stopAnimationWithCompletionTypeAndBackToDefaults(completionType: .error, backToDefaults: true, complete: nil)
        self.showMessage(sub: message)
    }
}
