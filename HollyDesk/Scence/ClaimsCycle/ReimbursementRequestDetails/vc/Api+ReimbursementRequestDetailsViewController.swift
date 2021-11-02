//
//  Api+ReimbursementRequestDetailsViewController.swift
//  HollyDesk
//
//  Created by rania refaat on 02/10/2021.
//

import UIKit

extension ReimbursementRequestDetailsViewController{
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
