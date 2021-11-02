//
//  PaymentWayViewController.swift
//  HollyDesk
//
//  Created by rania refaat on 23/07/2021.
//

import UIKit
import SSSpinnerButton

class PaymentWayViewController: UIViewController {
    
    //MARK:- outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableHeight: NSLayoutConstraint!
    @IBOutlet weak var mobilePhoneTF: UITextField!
    @IBOutlet weak var fullNameTF: UITextField!
    @IBOutlet weak var bankNameTF: UITextField!
    @IBOutlet weak var bankAddressTF: UITextField!
    @IBOutlet weak var bankAccountNumberTF: UITextField!
    @IBOutlet weak var bankStackView: UIStackView!
    @IBOutlet weak var eWalletStackView: UIStackView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var cashInformationView: UIView!
    @IBOutlet weak var cashOutButton: SSSpinnerButton!
    
    //MARK:- variables
    let message = Messages()
    let screenTitle = ScreenTitle()
    var walletTypeArray = [WalletTypeModelWallet]()
    var selectedIndex = -1
    var selectedType : WalletType?
    var amount = String()
    var paymentWay : PaymentWay = .all
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = screenTitle.paymentWay
        setupTableView()
        setupTF()
        getPaymentWayData()
        handelHiddenViews(walletType: .non)
    }
    private func setupTF(){
        mobilePhoneTF.addPadding(.left(8))
        fullNameTF.addPadding(.left(8))
        bankNameTF.addPadding(.left(8))
        bankAddressTF.addPadding(.left(8))
        bankAccountNumberTF.addPadding(.left(8))
        mobilePhoneTF.keyboardType = .asciiCapableNumberPad
    }
    //MARK:- setupTableView
    func setupTableView(){
        tableView.register(PaymentWayTableViewCell.nib, forCellReuseIdentifier: "PaymentWayTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        tableView.layer.removeAllAnimations()
        tableHeight.constant = tableView.contentSize.height
        UIView.animate(withDuration: 0.5) {
            self.updateViewConstraints()
            self.loadViewIfNeeded()
        }
    }

    
    func handelHiddenViews(walletType: WalletType){
        cashInformationView.isHidden = false
        cashOutButton.isHidden = false
        
        switch walletType {
        case .bank:
            bankStackView.isHidden = false
            eWalletStackView.isHidden = true
            selectedType = .bank
        case .eWallet:
            bankStackView.isHidden = true
            eWalletStackView.isHidden = false
            selectedType = .eWallet
        case .non:
            bankStackView.isHidden = true
            eWalletStackView.isHidden = true
            cashInformationView.isHidden = true
            cashOutButton.isHidden = true
        default:
            break
        }
    }
    @IBAction func cashOutButtonTapped(_ sender: SSSpinnerButton) {
        if selectedIndex == -1 {
            showMessage(sub: message.paymentWay)
        }else{
            checkInputs()
        }
    }
    private func checkInputs(){
        let phone = mobilePhoneTF.text!
        let name = fullNameTF.text!
        let bankAddress = bankAddressTF.text!
        let bankName = bankNameTF.text!
        let bankAccountNumber = bankAccountNumberTF.text!
        
        switch selectedType {
        case .bank:
            if isNotEmptyString(text: name, withAlertMessage: message.nameMessage) && isNotEmptyString(text:bankAddress, withAlertMessage: message.bankAddressMessage) && isNotEmptyString(text: bankName, withAlertMessage: message.bankNameMessage) && isNotEmptyString(text: bankAccountNumber, withAlertMessage: message.bankNumberMessage){
                setParams(name: name, bankAddress: bankAddress, bankName: bankName, bankAccountNumber: bankAccountNumber, phone: nil)
            }
        case .eWallet:
            if isNotEmptyString(text: phone, withAlertMessage: message.phoneMessage){
                    setParams(name: name, bankAddress: bankAddress, bankName: bankName, bankAccountNumber: bankAccountNumber, phone: phone)
            }
        default:
            break
            
        }
    }
    
    private func setParams(name: String, bankAddress: String , bankName: String , bankAccountNumber: String , phone: String?){
        var params = ["amount":amount,
                      "method":selectedType?.title
        ]as[String:AnyObject]
        
        if phone == nil {
            params["name"] = name as AnyObject
            params["bank"] = bankName as AnyObject
            params["bankAddress"] = bankAddress as AnyObject
            params["accountNumber"] = bankAccountNumber as AnyObject
        }else{
            params["phone"] = phone! as AnyObject
        }
        AddRequest(parameters: params)
    }
}
enum PaymentWay: String, Codable {
    case all
    case portion
}
