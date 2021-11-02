//
//  Api+AddAdvanceClaim.swift
//  HollyDesk
//
//  Created by rania refaat on 13/08/2021.
//

import UIKit
extension AddAdvanceClaimViewController{
    func AddRequest(parameters : [String:AnyObject]) {
        var url : ServiceName
        url = .addInAdvanceRequest

        switch self.requestScreenType {
        case .add:
            url = .addInAdvanceRequest
        case .edit:
            url = .editInAdvanceRequest
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
