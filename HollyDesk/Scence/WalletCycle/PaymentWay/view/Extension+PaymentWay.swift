//
//  Extension+PaymentWay.swift
//  HollyDesk
//
//  Created by rania refaat on 23/07/2021.
//

import UIKit

extension PaymentWayViewController : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return walletTypeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PaymentWayTableViewCell", for: indexPath) as! PaymentWayTableViewCell
        cell.selectionStyle = .none
        let wallet = walletTypeArray[indexPath.row]
        cell.config(item: wallet)
        if selectedIndex == indexPath.row{
            cell.walletSelectedImage.isHidden = false
        }else{
            cell.walletSelectedImage.isHidden = true
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        tableView.reloadData()
        let walletType = walletTypeArray[indexPath.row].type ?? .non
        handelHiddenViews(walletType: walletType)
        
    }
}
