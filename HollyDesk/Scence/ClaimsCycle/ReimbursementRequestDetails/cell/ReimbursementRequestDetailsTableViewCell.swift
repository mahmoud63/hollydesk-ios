//
//  ReimbursementRequestDetailsTableViewCell.swift
//  HollyDesk
//
//  Created by rania refaat on 28/08/2021.
//

import UIKit

class ReimbursementRequestDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var imageNameLabel: UILabel!
    @IBOutlet weak var requestImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        requestImageView.layer.cornerRadius = 4
        requestImageView.layer.masksToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    static var nib : UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier : String {
        return String(describing: self)
    }
    func configCell(image: String , name: String){
        imageNameLabel.text = name
        requestImageView.loadImageUrl(image)
    }
    
}
