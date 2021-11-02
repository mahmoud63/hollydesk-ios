//
//  Extension+HomeVC.swift
//  HollyDesk
//
//  Created by rania refaat on 10/07/2021.
//

import UIKit

extension HomeViewController : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeRequestArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
        cell.selectionStyle = .none
        let request = homeRequestArray[indexPath.row]
        cell.configCell(request: request)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 76
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let requestType = homeRequestArray[indexPath.row].requestType ?? ""
        let request = homeRequestArray[indexPath.row]
        
        if requestType == "reimbursement" {
            let vc = InAdvanceRequestDetailsViewController()
            vc.requestType = .reimbursement
            vc.requestID = request.id ?? ""
            show(vc, sender: self)

        }else if requestType == "inadvance"{
            let vc = InAdvanceRequestDetailsViewController()
            vc.requestType = .reimbursement
            vc.requestID = request.id ?? ""
            show(vc, sender: self)
        }
    }
}
extension HomeViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        print(indexPaths)
//        for index in indexPaths {
//            if index.row == OrdersArray.count - 1 {
//                print(index.row , " " ,OrdersArray.count )
//                if totalPages == nil || totalPages == currentPage {
//                    return
//                }else {
//                    self.currentPage += 1
//                    getOrdersData(loading: false)
//                    break
//                }
//            }
//        }
        
    }
}
