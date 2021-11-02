//
//  Api+AdvanceClaimViewController.swift
//  HollyDesk
//
//  Created by rania refaat on 17/07/2021.
//

import UIKit

extension AdvanceClaimViewController{
    func getRequestsData(loading: Bool) {
        DispatchQueue.main.async {
            if loading {
                self.currentPage = 1
                self.tableView.showLoader()
            }
            var parm = ["page" : "\(self.currentPage)"]
            parm["filter"] = self.status.title
            
            self.isFetching = true
            let manager = Manager()
            manager.perform(RequestsModel.self, serviceName: .inadvanceRequests, method: .get,getWithParams: true , authenticationEnabled: true , parameters: parm) {[weak self] (result) in
                guard let self = self else {return}
                switch result {
                case .success(let model):
                    self.view.isUserInteractionEnabled = true
                    if model.data == nil{
                        self.responseFail(message: model.message ?? "")
                    }else{
                        self.tableView.dismissLoader()
                        if loading {
                            self.requestArray = model.data?.requests ?? []
                        }else{
                            self.requestArray.append(contentsOf: model.data?.requests ?? [])
                        }
                        if loading {
                            self.tableView.reloadData()
                        }else{
                            self.tableView.reloadData()
                        }
                        if self.requestArray.count == 0 {
                            self.tableView.setEmptyView(messageImage: #imageLiteral(resourceName: "mirage-list-is-empty"), title: self.screenTitle.noRequests , message: nil)
                        }else{
                            self.tableView.restore()
                        }
                        self.totalCount = model.data?.count

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
}
