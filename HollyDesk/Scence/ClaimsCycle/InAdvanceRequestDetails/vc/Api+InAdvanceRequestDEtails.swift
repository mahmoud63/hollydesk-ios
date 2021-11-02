//
//  Api+InAdvanceRequestDEtails.swift
//  HollyDesk
//
//  Created by rania refaat on 28/08/2021.
//

import UIKit

extension InAdvanceRequestDetailsViewController{
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
extension InAdvanceRequestDetailsViewController{
    func DraftRequestImages(parameters : [String:AnyObject]) {
        var url : ServiceName
        url = .inAdvanceDraftImages

        DispatchQueue.main.async {
            self.view.isUserInteractionEnabled = false
            self.draftButton.startAnimate(spinnerType: .circleStrokeSpin, spinnercolor: .white, spinnerSize: 20, complete: nil)
            
            let manager = Manager()
            
            manager.perform(AddRequestModel.self, serviceName: url, method: .post, authenticationEnabled: true, parameters: parameters) {[weak self] (result) in
                guard let self = self else {return}
                switch result {
                case .success(let model):
                    self.AddResponseFail(message: model.message ?? "")
                    self.draftButton.stopAnimationWithCompletionTypeAndBackToDefaults(
                        completionType: .success,
                        backToDefaults: true,
                        complete: {
                            self.popView()
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
        self.draftButton.stopAnimationWithCompletionTypeAndBackToDefaults(completionType: .error, backToDefaults: true, complete: nil)
        self.showMessage(sub: message)
        
    }
}
extension InAdvanceRequestDetailsViewController{
    func SubmitRequestImages(parameters : [String:AnyObject]) {
        var url : ServiceName
        url = .inAdvanceSubmitImages

        DispatchQueue.main.async {
            self.view.isUserInteractionEnabled = false
            self.submitButton.startAnimate(spinnerType: .circleStrokeSpin, spinnercolor: .white, spinnerSize: 20, complete: nil)
            
            let manager = Manager()
            
            manager.perform(AddRequestModel.self, serviceName: url, method: .post, authenticationEnabled: true, parameters: parameters) {[weak self] (result) in
                guard let self = self else {return}
                switch result {
                case .success(let model):
                    self.AddResponseFail2(message: model.message ?? "")
                    self.submitButton.stopAnimationWithCompletionTypeAndBackToDefaults(
                        completionType: .success,
                        backToDefaults: true,
                        complete: {
                            self.popView()
                        })
                    
                    break
                case .failure(let err):
                    self.AddResponseFail2(message: err!.localizedDescription)
                case .noConnection:
                    self.AddResponseFail2(message: self.message.noConnectionMessage)
                }
            }
            self.view.isUserInteractionEnabled = true

        }
    }
    func AddResponseFail2(message : String){
        self.submitButton.stopAnimationWithCompletionTypeAndBackToDefaults(completionType: .error, backToDefaults: true, complete: nil)
        self.showMessage(sub: message)
        
    }
}
extension InAdvanceRequestDetailsViewController{
    func getRequestsDetails() {
        self.view.showLoader()
        DispatchQueue.main.async {
            var param = ["id" : "\(self.requestID)"]
            let manager = Manager()
            manager.perform(RequestDetailsModel.self, serviceName: .home, method: .get,getWithParams: true , authenticationEnabled: true , parameters: param) {[weak self] (result) in
                guard let self = self else {return}
                self.view.dismissLoader()
                switch result {
                case .success(let model):
                    self.view.isUserInteractionEnabled = true
                    if model.data == nil{
                        self.responseFail(message: model.message ?? "")
                    }else{
                        self.request = self.fillVM(data: model.data!)
                        self.setData()
                    }
                    break
                case .failure(let err):
                    self.responseRequestFail(message: err!.localizedDescription)
                case .noConnection(_):
                    self.responseRequestFail(message: self.message.noConnectionMessage)
                }
            }
        }
    }
    func responseRequestFail(message : String){
        self.showMessage(sub: message)
        self.tableView.dismissLoader()
    }
    
    func fillVM(data: RequestDetailsModelData)-> RequestDetailsViewModel{
        var vm = RequestDetailsViewModel()
        let submissionDate = getPaidTime(time: data.createdAt)
        let payDate = getPaidTime(time: data.paidOn)

        vm.currency = data.currency
        vm.submissionDate = submissionDate
        vm.team = data.team
        vm.shortStatus = data.shortStatus
        vm.totalAmount = data.amount

        vm.images = data.images
        vm.payDate = payDate
        vm.payTo = data.paidTo
        vm.payFor = data.paidFor
        vm.requestID = data.id
        vm.status = data.status
        
        vm.images = data.images
        vm.isReceived = data.received
        vm.requestShortStatus = data.requestShortStatus
        vm.reconsileShortStatus = data.reconsileShortStatus

        return vm
    }
}
