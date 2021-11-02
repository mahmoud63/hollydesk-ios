//
//  PaymentWayTableViewCell.swift
//  HollyDesk
//
//  Created by rania refaat on 23/07/2021.
//

import UIKit

class PaymentWayTableViewCell: UITableViewCell {

    @IBOutlet weak var walletSelectedImage: UIImageView!
    @IBOutlet weak var walletNameLabel: UILabel!
    @IBOutlet weak var walletImageView: UIImageView!
    
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
    
    func config(item: WalletTypeModelWallet?){
        walletNameLabel.text = item?.name
        walletImageView.loadImageUrl(item?.image)
    }
}
