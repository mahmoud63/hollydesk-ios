//
//  Api+PaymentWay.swift
//  HollyDesk
//
//  Created by rania refaat on 23/07/2021.
//

import UIKit

extension PaymentWayViewController{
    func getPaymentWayData() {
        DispatchQueue.main.async {
            self.view.showLoader()
            let manager = Manager()
            manager.perform(WalletTypeModel.self, serviceName: .walletType, method: .get, authenticationEnabled: true) {[weak self] (result) in
                guard let self = self else {return}
                switch result {
                case .success(let model):
                    self.view.isUserInteractionEnabled = true
                    if model.data == nil{
                        self.responseFaile(message: model.message ?? "")
                    }else{
                        self.view.dismissLoader()
                        self.walletTypeArray = model.data?.wallets ?? []
                        if self.walletTypeArray.count != 0 {
                            self.selectedIndex = 0
                            let walletType = self.walletTypeArray[0].type ?? .non
                            self.handelHiddenViews(walletType: walletType)

                        }
                        self.tableView.reloadData()
                    }
                    break
                case .failure(let err):
                    self.responseFaile(message: err!.localizedDescription)
                case .noConnection:
                    self.responseFaile(message: self.message.noConnectionMessage)
                }
            }
        }
    }
    func responseFaile(message : String){
        self.showMessage(sub: message)
        self.view.dismissLoader()
        
    }
}
extension PaymentWayViewController{
    func AddRequest(parameters : [String:AnyObject]) {
        DispatchQueue.main.async {
            
            self.view.isUserInteractionEnabled = false
            self.cashOutButton.startAnimate(spinnerType: .circleStrokeSpin, spinnercolor: .white, spinnerSize: 20, complete: nil)
            
            let manager = Manager()
            
            manager.perform(cashOutModel.self, serviceName: .cashOut, method: .post, authenticationEnabled: true, parameters: parameters) {[weak self] (result) in
                guard let self = self else {return}
                switch result {
                case .success(let model):
                    if model.data == nil{
                        self.AddResponseFail(message: model.message ?? "")
                    }else{
                        self.cashOutButton.stopAnimationWithCompletionTypeAndBackToDefaults(
                            completionType: .success,
                            backToDefaults: true,
                            complete: {
                                self.showMessage(sub: model.message ?? "")
                                self.popToRootView()
                            })
                    }
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
        self.cashOutButton.stopAnimationWithCompletionTypeAndBackToDefaults(completionType: .error, backToDefaults: true, complete: nil)
        self.showMessage(sub: message)
        
    }
}
