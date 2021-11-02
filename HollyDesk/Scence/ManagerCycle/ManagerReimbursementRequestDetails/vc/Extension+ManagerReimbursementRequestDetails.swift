//
//  Extension+ManagerReimbursementRequestDetails.swift
//  HollyDesk
//
//  Created by rania refaat on 02/10/2021.
//

import UIKit
import Kingfisher

extension ManagerReimbursementRequestDetailsViewController : UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return request?.images?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ManagerReimbursementRequestDetailsTableViewCell", for: indexPath) as! ManagerReimbursementRequestDetailsTableViewCell
        cell.selectionStyle = .none
        let imageRequest = request?.images?[indexPath.row]
        let image = imageRequest?.path ?? ""
        let name = imageRequest?.name ?? ""

        cell.configCell(name: name)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 42
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let imageRequest = request?.images?[indexPath.row].path ?? ""

        if let url = URL(string: imageRequest){
            downloadImage(from: url)
        }

    }
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    func downloadImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            // always update the UI from the main thread
            DispatchQueue.main.async() { [weak self] in
                if let image = UIImage(data: data){
                    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                }

            }
        }
    }
}
