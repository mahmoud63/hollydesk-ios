//
//  Api+HomeVC.swift
//  HollyDesk
//
//  Created by rania refaat on 14/07/2021.
//

import UIKit

extension HomeViewController{
    func getHomeData() {
        DispatchQueue.main.async {
            self.view.showLoader()
            let manager = Manager()
            manager.perform(HomeModel.self, serviceName: .home, method: .get, authenticationEnabled: true) {[weak self] (result) in
                guard let self = self else {return}
                switch result {
                case .success(let model):
                    self.view.isUserInteractionEnabled = true
                    if model.data == nil{
                        self.responseFaile(message: model.message ?? "")
                    }else{
                        self.view.dismissLoader()
                        self.homeRequestArray = model.data?.requests ?? []
                        guard let credit = model.data?.credit else {return}
                        self.creditLabel.text = "\(credit)"
                        UserDefaultData.save_user_int_data(key: UserDefaultDataKeys.credit, value: credit)
                        if self.homeRequestArray.count == 0 {
                            self.tableView.setEmptyView(messageImage: #imageLiteral(resourceName: "mirage-list-is-empty"), title: self.screenTitle.noRequests, message: nil)
                        }else{
                            self.tableView.restore()
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
