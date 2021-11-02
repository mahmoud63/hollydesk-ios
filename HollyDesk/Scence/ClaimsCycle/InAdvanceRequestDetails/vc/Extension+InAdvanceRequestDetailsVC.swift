//
//  Extension+InAdvanceRequestDetailsVC.swift
//  HollyDesk
//
//  Created by rania refaat on 28/08/2021.
//

import Foundation
import UIKit

extension InAdvanceRequestDetailsViewController : UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedImages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InAdvanceRequestDetailsTableViewCell", for: indexPath) as! InAdvanceRequestDetailsTableViewCell
        cell.selectionStyle = .none

        cell.configCell(image: selectedImages[indexPath.row])
        
        let requestStatus = request?.requestShortStatus ?? 0
        let consilStatus = request?.reconsileShortStatus ?? 0
        
        if (requestStatus == 1 && consilStatus == 0){
            draftButton.isHidden = false
            cell.deleteButton.isHidden = false

        } else if (requestStatus == 1 && consilStatus == -1){
            draftButton.isHidden = false
            cell.deleteButton.isHidden = false

        }else if (requestStatus == 1 && consilStatus == -3){
            draftButton.isHidden = false
            cell.deleteButton.isHidden = false

        }else {
            cell.deleteButton.isHidden = true
            draftButton.isHidden = true
        }
        
        cell.deleteHandler = {
            self.selectedImages.remove(at: indexPath.row)
            self.tableView.reloadData()
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 62
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}
extension InAdvanceRequestDetailsViewController : ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        guard let selectedImage = image else {
            return
        }
        uploadImagePic(img1: selectedImage)
    }
}
