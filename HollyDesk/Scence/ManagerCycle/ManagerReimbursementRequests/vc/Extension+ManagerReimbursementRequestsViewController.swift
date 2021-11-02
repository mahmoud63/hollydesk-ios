//
//  Extension+ManagerReimbursementRequestsViewController.swift
//  HollyDesk
//
//  Created by rania refaat on 02/10/2021.
//

import UIKit

extension ManagerReimbursementRequestsViewController : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return requestArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ManagerReimbursementRequestsTableViewCell", for: indexPath) as! ManagerReimbursementRequestsTableViewCell
        cell.selectionStyle = .none
        let request = requestArray[indexPath.row]
        cell.configCell(request: request)

        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 76
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let request = requestArray[indexPath.row]
        let vc = ManagerReimbursementRequestDetailsViewController()
        vc.requestID = request.requestID ?? ""
        show(vc, sender: self)
    }
}
extension ManagerReimbursementRequestsViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for index in indexPaths {
            if index.row == requestArray.count - 1 {
                if totalCount == requestArray.count {
                    return
                }else {
                    self.currentPage += 1
                    getRequestsData(loading: false)
                    break
                }
            }
        }
        
    }
}
