//
//  Api+ManagerReimbursementRequestsViewController.swift
//  HollyDesk
//
//  Created by rania refaat on 02/10/2021.
//

import UIKit

extension ManagerReimbursementRequestsViewController{
    func getRequestsData(loading: Bool) {
        DispatchQueue.main.async {
            if loading {
                self.currentPage = 1
                self.tableView.showLoader()
            }
            var param = ["page" : "\(self.currentPage)"]
            param["filter"] = self.status.title
            
//            let arg = "approve-manager"//self.status.title
            
            self.isFetching = true
            let manager = Manager()
            manager.perform(RequestsModel.self, serviceName: .managerRequest, method: .get,getWithParams: true , authenticationEnabled: true , parameters: param) {[weak self] (result) in
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
                            self.tableView.setEmptyView(messageImage: #imageLiteral(resourceName: "mirage-list-is-empty"), title: self.screenTitle.noRequests, message: nil)
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
