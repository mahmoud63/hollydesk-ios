//
//  WalletViewController.swift
//  HollyDesk
//
//  Created by rania refaat on 22/07/2021.
//

import UIKit

class WalletViewController: UIViewController {

    //MARK:- outlets
    @IBOutlet weak var creditLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var allSelectedImage: UIImageView!
    @IBOutlet weak var portionSelectedImage: UIImageView!
    @IBOutlet weak var requiredMoneyTF: UITextField!
    @IBOutlet weak var maxAvailableLabel: UILabel!
    @IBOutlet weak var portionButton: UIButton!
    @IBOutlet weak var allButton: UIButton!
    
    //MARK:- variables
    let message = Messages()
    let screenTitle = ScreenTitle()
    let walletType : WalletType = .bank
    var paymentWay : PaymentWay = .all

    //MARK:- viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = screenTitle.wallet
        requiredMoneyTF.text = getUserData().1

    }
    
    //MARK:- viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        sideNavigation()
        nameLabel.text = "Hello".localized + ", \(getUserData().0)"
        creditLabel.text = getUserData().1
        maxAvailableLabel.text = "\(getUserData().1) " + "EGP".localized
        requiredMoneyTF.keyboardType = .asciiCapableNumberPad

    }
    
    @IBAction func selectCashButtonTapped(_ sender: UIButton) {
        let vc = PaymentWayViewController()
            vc.paymentWay = paymentWay
        switch paymentWay {
        case .all:
            vc.amount = getUserData().1
            show(vc, sender: self)
        case .portion:
            if !(requiredMoneyTF.text!.isEmpty) {
                vc.amount = requiredMoneyTF.text!
                show(vc, sender: self)
            }else{
                showMessage(sub: message.paymentAmount)
            }
        default:
            break
        }
    }
    
    @IBAction func cashButtonTapped(_ sender: UIButton) {
        switch sender {
        case allButton:
            allSelectedImage.image = AppImages.radioFilled
            portionSelectedImage.image = AppImages.radioEmpty
            requiredMoneyTF.text = getUserData().1
            maxAvailableLabel.text = "\(getUserData().1) " + "EGP".localized
            paymentWay = .all
        case portionButton:
            allSelectedImage.image = AppImages.radioEmpty
            portionSelectedImage.image = AppImages.radioFilled
            requiredMoneyTF.text = nil
            requiredMoneyTF.placeholder = nil
            maxAvailableLabel.text = "EGP".localized
            paymentWay = .portion

        default:
            break
        }
    }
    private func getUserData() -> (String , String){
        let name = UserDefaultData.get_user_string_data(key: UserDefaultDataKeys.fullName) ?? ""
        let credit = String(UserDefaultData.get_user_int_data(key: UserDefaultDataKeys.credit) ?? 0)
        return (name , credit)

    }
}
