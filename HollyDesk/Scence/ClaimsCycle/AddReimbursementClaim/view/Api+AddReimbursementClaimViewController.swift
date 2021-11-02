//
//  Api+AddReimbursementClaimViewController.swift
//  HollyDesk
//
//  Created by rania refaat on 21/07/2021.
//

import UIKit
extension AddReimbursementClaimViewController{
    func uploadImagePic(img1 :UIImage ){
        let manager = Manager()
        self.view.isUserInteractionEnabled = false
        self.view.showLoader()
        manager.performImages(AddRequestImageModel.self, serviceName: .addImageRequest, method: .post , image: img1, authenticationEnabled: true , imageName: "file", parameters: nil) {[weak self] (result) in
            guard let self = self else {return}
            self.view.dismissLoader()
            switch result {
            case .success(let model):
                if model.data == nil{
                    self.responseFail(message: model.message ?? "")
                }else{
                    guard let dataArray = model.data else {
                        return
                    }
                    self.selectedImages.append(contentsOf: dataArray)
                    self.tableView.reloadData()
                }
                break
            case .failure(let err):
                self.responseFail(message: err!.localizedDescription)
            case .noConnection:
                self.responseFail(message: self.message.noConnectionMessage)
            }
        }
        self.view.isUserInteractionEnabled = true
        
    }
    func responseFail(message : String){
        self.view.dismissLoader()
        self.showMessage(sub: message)
    }
}
extension AddReimbursementClaimViewController{
    func AddRequest(parameters : [String:AnyObject]) {
        var url : ServiceName
        url = .addRequest

        switch self.requestScreenType {
        case .add:
            url = .addRequest
        case .edit:
            url = .editIReimbursementRequest
        default:
            break
        }
        DispatchQueue.main.async {
            self.view.isUserInteractionEnabled = false
            self.confirmButton.startAnimate(spinnerType: .circleStrokeSpin, spinnercolor: .white, spinnerSize: 20, complete: nil)
            
            let manager = Manager()
            
            manager.perform(AddRequestModel.self, serviceName: url, method: .post, authenticationEnabled: true, parameters: parameters) {[weak self] (result) in
                guard let self = self else {return}
                switch result {
                case .success(let model):
                    self.AddResponseFail(message: model.message ?? "")
                    self.confirmButton.stopAnimationWithCompletionTypeAndBackToDefaults(
                        completionType: .success,
                        backToDefaults: true,
                        complete: {
                            self.popToRootView()
                        })
                    
                    break
                case .failure(let err):
                    self.AddResponseFail(message: err!.localizedDescription)
                case .noConnection:
                    self.AddResponseFail(message: self.message.noConnectionMessage)
                }
            }
            self.view.isUserInteractionEnabled = true

        }
    }
    func AddResponseFail(message : String){
        self.confirmButton.stopAnimationWithCompletionTypeAndBackToDefaults(completionType: .error, backToDefaults: true, complete: nil)
        self.showMessage(sub: message)
        
    }
}
