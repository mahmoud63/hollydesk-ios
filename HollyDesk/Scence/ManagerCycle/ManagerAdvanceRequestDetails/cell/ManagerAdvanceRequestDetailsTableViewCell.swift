//
//  ManagerAdvanceRequestDetailsTableViewCell.swift
//  HollyDesk
//
//  Created by rania refaat on 02/10/2021.
//

import UIKit

class ManagerAdvanceRequestDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var imageNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
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
    func configCell(name: String){
        imageNameLabel.text = name
    }
    
}
