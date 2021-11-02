//
//  HomeTableViewCell.swift
//  HollyDesk
//
//  Created by rania refaat on 10/07/2021.
//

import UIKit
import Kingfisher

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var reqImageView: UIImageView!
    @IBOutlet weak var paidForLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var reqAmountLabel: UILabel!
    @IBOutlet weak var paidOnLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        reqImageView.layer.cornerRadius = 8
        reqImageView.layer.borderWidth = 0.8
        reqImageView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
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
    
    func configCell(request: HomeRequest){
        if request.images?.count == 0 {
            reqImageView.image = AppImages.Logo
        }else{
            let image = request.images?[0].path ?? ""
            reqImageView.loadImageUrl(image)
        }
        let currency = request.currency ?? "EGP".localized
        handleStatus(status: request.shortStatus)
        paidForLabel.text = request.paidTo
        reqAmountLabel.text = "\(request.amount ?? 0) " + "EGP".localized
        paidOnLabel.text = getPaidTime(time: request.paidOn)
    }
    
    private func getPaidTime(time : String?)-> String{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSS'Z'"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "yyyy-MM-dd"
        dateFormatterPrint.locale = Locale(identifier: "en_US")

        if let startDate = dateFormatterGet.date(from: time ?? "") {
            return  dateFormatterPrint.string(from: startDate)
        } else {
            return ""
        }
    }
    private func handleStatus(status: RequestStatus?){
        statusLabel.text = status?.arTitle
        
        switch status {
        case .pending, .Pending:
            statusLabel.textColor = AppColor.MainOrange
        case .approved, .Approved:
            statusLabel.textColor = AppColor.MainDarkGreen
        case .declined, .Declined:
            statusLabel.textColor = AppColor.MainDarkRed
        case .reconciliationApproved, .ReconciliationApproved:
            statusLabel.textColor = AppColor.MainDarkGreen
        default:
            break
        }

    }
}
