//
//  Extension+ReimbursementRequestDetailsVC.swift
//  HollyDesk
//
//  Created by rania refaat on 28/08/2021.
//

import UIKit

extension ReimbursementRequestDetailsViewController : UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return request?.images?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReimbursementRequestDetailsTableViewCell", for: indexPath) as! ReimbursementRequestDetailsTableViewCell
        cell.selectionStyle = .none
        let imageRequest = request?.images?[indexPath.row]
        let image = imageRequest?.path ?? ""
        let name = imageRequest?.name ?? ""

        cell.configCell(image: image, name: name)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 62
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}
