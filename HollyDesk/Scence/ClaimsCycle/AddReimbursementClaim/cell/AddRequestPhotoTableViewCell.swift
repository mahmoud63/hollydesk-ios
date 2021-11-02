//
//  AddRequestPhotoTableViewCell.swift
//  HollyDesk
//
//  Created by rania refaat on 12/08/2021.
//

import UIKit

class AddRequestPhotoTableViewCell: UITableViewCell {

    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var imageNameLabel: UILabel!
    @IBOutlet weak var requestImageView: UIImageView!
    
    var deleteHandler : ActionClouser?

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
    func configCell(image: Image){
        imageNameLabel.text = image.name
        requestImageView.loadImageUrl(image.path)
    }
    
    @IBAction func deleteButtonTapped(_ sender: UIButton) {
        deleteHandler?()
    }
}
typealias ActionClouser = ()  -> Void
