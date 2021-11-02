//
//  Extension+AdvanceClaimViewController.swift
//  HollyDesk
//
//  Created by rania refaat on 11/07/2021.
//

import UIKit

extension AdvanceClaimViewController : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return requestArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AdvanceClaimTableViewCell", for: indexPath) as! AdvanceClaimTableViewCell
        cell.selectionStyle = .none
        var request = requestArray[indexPath.row]
        request.shortStatus = status
        cell.configCell(request: request)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 76
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let request = requestArray[indexPath.row]
        let vc = InAdvanceRequestDetailsViewController()
        vc.requestType = .reimbursement
        vc.requestID = request.requestID ?? ""
        show(vc, sender: self)
    }
}
extension AdvanceClaimViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        print(indexPaths)
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
