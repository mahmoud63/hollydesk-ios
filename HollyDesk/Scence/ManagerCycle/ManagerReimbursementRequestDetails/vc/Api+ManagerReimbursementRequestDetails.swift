//
//  Api+ManagerReimbursementRequestDetails.swift
//  HollyDesk
//
//  Created by rania refaat on 02/10/2021.
//

import UIKit

extension ManagerReimbursementRequestDetailsViewController{
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
                    self.responseFail(message: err!.localizedDescription)
                case .noConnection(_):
                    self.responseFail(message: self.message.noConnectionMessage)
                }
            }
        }
    }
    func responseFail(message : String){
        self.showMessage(sub: message)
        self.tableView.dismissLoader()
    }
    
    func fillVM(data: RequestDetailsModelData)-> ManagerRequestDetailsViewModel{
        var vm = ManagerRequestDetailsViewModel()
        let submissionDate = getPaidTime(time: data.createdAt)
        let payDate = getPaidTime(time: data.paidOn)
        vm.images = data.images

        vm.fromUserImage = data.from?.image?.path
        vm.fromUserName = "\(data.from?.firstName ?? "")" + " \(data.from?.lastName ?? "")"
        vm.fromUserTeam = data.team

        if data.images?.count != 0 {
            vm.toUserImage = data.images?[0].path
        }

        vm.toUserName = data.paidTo
        vm.payDate = payDate
        vm.currency = data.currency
        vm.submissionDate = submissionDate
        vm.images = data.images
        vm.payFor = data.paidFor
        vm.requestID = data.id
        vm.shortStatus = data.shortStatus
        vm.totalAmount = data.amount

        return vm
    }
}
extension ManagerReimbursementRequestDetailsViewController{
    func requestActionDetails(type: String) {
        var url : ServiceName
        if type == "accept" {
            url = .managerAcceptReimbursement
        }else if type == "deny"{
            url = .managerDenyReimbursement
        }else{
            url = .requests
        }

        DispatchQueue.main.async {
            self.view.isUserInteractionEnabled = false
            if type == "accept" {
                self.acceptButton.startAnimate(spinnerType: .circleStrokeSpin, spinnercolor: .white, spinnerSize: 20, complete: nil)
            }else if type == "deny"{
                self.cancelButton.startAnimate(spinnerType: .circleStrokeSpin, spinnercolor: .white, spinnerSize: 20, complete: nil)
            }
            
            let manager = Manager()
            
            manager.perform(AddRequestModel.self, serviceName: url, method: .post, authenticationEnabled: true, parameters: ["requestsIDs":self.requestID]) {[weak self] (result) in
                guard let self = self else {return}
                switch result {

                case .success(let model):
                    self.showMessage(sub: model.message)

                    if type == "accept" {
                        self.acceptButton.stopAnimationWithCompletionTypeAndBackToDefaults(
                            completionType: .success,
                            backToDefaults: true,
                            complete: {
                                self.popView()
                            })
                        
                    }else if type == "deny"{
                        self.cancelButton.stopAnimationWithCompletionTypeAndBackToDefaults(
                            completionType: .success,
                            backToDefaults: true,
                            complete: {
                                self.popView()
                            })
                        
                    }
                    
                    break
                case .failure(let err):
                    self.requestActionDetailsFail(message: err!.localizedDescription, type: type)
                case .noConnection:
                    self.requestActionDetailsFail(message: self.message.noConnectionMessage, type: type)
                }
            }
            self.view.isUserInteractionEnabled = true

        }
    }
    func requestActionDetailsFail(message : String , type: String){
        if type == "accept" {
            self.acceptButton.stopAnimationWithCompletionTypeAndBackToDefaults(completionType: .error, backToDefaults: true, complete: nil)
        }else if type == "deny"{
            self.cancelButton.stopAnimationWithCompletionTypeAndBackToDefaults(completionType: .error, backToDefaults: true, complete: nil)
        }
        self.showMessage(sub: message)
        
    }
}
