//
//  Table+AddReimbursementClaimViewController.swift
//  HollyDesk
//
//  Created by rania refaat on 12/08/2021.
//

import UIKit

extension AddReimbursementClaimViewController : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedImages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddRequestPhotoTableViewCell", for: indexPath) as! AddRequestPhotoTableViewCell
        cell.selectionStyle = .none
        cell.configCell(image: selectedImages[indexPath.row])
        
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
extension AddReimbursementClaimViewController : ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        guard let selectedImage = image else {
            return
        }
        uploadImagePic(img1: selectedImage)
    }
}
