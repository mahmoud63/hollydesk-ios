//
//  AddReimbursementClaimViewController.swift
//  HollyDesk
//
//  Created by rania refaat on 20/07/2021.
//

import UIKit
import SSSpinnerButton
import SwiftyJSON

class AddReimbursementClaimViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var currencyTF: UITextField!
    @IBOutlet weak var totalAmountTF: UITextField!
    @IBOutlet weak var paidToTF: UITextField!
    @IBOutlet weak var paidDateTF: UITextField!
    @IBOutlet weak var receivedCheckImage: UIImageView!
    @IBOutlet weak var confirmButton: SSSpinnerButton!
    @IBOutlet weak var paidForTF: UITextField!
    @IBOutlet weak var tableHeight: NSLayoutConstraint!

    //MARK:- variables
    let message = Messages()
    let screenTitle = ScreenTitle()
    var imagePicker : ImagePicker!
    var selectedImages = [Image]()
    var isReceived = false
    var requestScreenType: RequestScreenType?
    var requestVM : RequestDetailsViewModel?
    
    //MARK:- viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupTF()
        textFieldImage()
        imagePicker = ImagePicker(presentationController: self, delegate: self)
        currencyTF.text = "EGP".localized
        currencyTF.isEnabled = false
        
        if requestScreenType == .edit {
            title = screenTitle.editRequest
        }else if requestScreenType == .add {
            title = screenTitle.newRequest
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if requestScreenType == .edit {
            setEditData()
        }else if requestScreenType == .add {
        }
        if requestScreenType == .edit {
            confirmButton.setTitle(screenTitle.save, for: .normal)
        }else if requestScreenType == .add {
            confirmButton.setTitle(screenTitle.addRequest, for: .normal)
        }
    }
    //MARK:- setupTableView
    func setupTableView(){
        tableView.register(AddRequestPhotoTableViewCell.nib, forCellReuseIdentifier: "AddRequestPhotoTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
    }
    //MARK:- setEditData
    func setEditData(){
        currencyTF.text = "EGP".localized//requestVM?.currency
        totalAmountTF.text = "\(Int(requestVM?.totalAmount ?? 0))"
        paidToTF.text = requestVM?.payTo
        paidForTF.text = requestVM?.payFor
        paidDateTF.text = requestVM?.payDate
        selectedImages = requestVM?.images ?? []
//        isReceived = requestVM?.isReceived ?? false
//        if isReceived{
//            receivedCheckImage.image = AppImages.checkFilled
//        }else{
//            receivedCheckImage.image = AppImages.checkEmpty
//        }
        tableView.reloadData()
    }
    //MARK:- observeValue
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        tableView.layer.removeAllAnimations()
        tableHeight.constant = tableView.contentSize.height
        UIView.animate(withDuration: 0.5) {
            self.updateViewConstraints()
            self.loadViewIfNeeded()
        }
    }
    //MARK:- setupTF
    private func setupTF(){
        currencyTF.addPadding(.left(8))
        paidToTF.addPadding(.left(8))
        paidDateTF.addPadding(.left(8))
        paidForTF.addPadding(.left(8))
        totalAmountTF.keyboardType = .asciiCapableNumberPad
    }
    
    //MARK:- textFieldImage
    private func textFieldImage(){
        let imageContainerView: UIView = UIView(frame: CGRect(x: currencyTF.frame.size.width / 2 , y: currencyTF.frame.size.height / 2, width: 30 , height: 30))
        let imageView = UIImageView(frame: CGRect(x: imageContainerView.frame.size.width / 2, y: imageContainerView.frame.size.height / 2, width: 10, height: 10))
        imageView.image = #imageLiteral(resourceName: "arrow-down")
        imageContainerView.addSubview(imageView)
        currencyTF.rightView = imageContainerView
        currencyTF.rightViewMode = .always
        currencyTF.tintColor = .lightGray
    }
    //MARK:- receivedButtonTapped
    @IBAction func receivedButtonTapped(_ sender: UIButton) {
        if isReceived{
            isReceived = false
            receivedCheckImage.image = AppImages.checkEmpty
        }else{
            isReceived = true
            receivedCheckImage.image = AppImages.checkFilled
        }
    }
    //MARK:- confirmButtonTapped
    @IBAction func confirmButtonTapped(_ sender: SSSpinnerButton) {
        let amount = totalAmountTF.text!
        let currency = currencyTF.text!
        let paidTo = paidToTF.text!
        let paidFor = paidForTF.text!
        let paidDate = paidDateTF.text!
        
        if isNotEmptyString(text: amount, withAlertMessage: message.amountMessage) && isNotEmptyString(text:currency, withAlertMessage: message.currencyMessage) && isNotEmptyString(text: self.paidToTF.text!, withAlertMessage: message.paidToMessage) && isNotEmptyString(text: paidFor, withAlertMessage: message.paidForMessage) && isNotEmptyString(text: paidDate, withAlertMessage: message.paidDateMessage){
            if selectedImages.count == 0 {
                showMessage(sub: message.paidImagesMessage)
            }else{
                    var params = ["amount":amount,
                                  "currency":currency,
                                  "paidTo":paidTo,
                                  "paidFor":paidFor,
                                  "date": paidDate,
                                  "received" : "\(isReceived)"
                    ]as[String:AnyObject]
                    var imagesString = String()
                    for (n, prime) in selectedImages.enumerated()
                    {
                        if n == 0 {
                            imagesString += prime.id ?? ""
                        }else{
                            imagesString += ",\(prime.id ?? "")"
                        }
                    }
                    params["images"] =  imagesString as AnyObject
                switch self.requestScreenType {
                case .edit:
                    params["id"] = requestVM?.requestID as AnyObject?
                default:
                    break
                }
                    AddRequest(parameters: params)
                }
        }
        
    }
    
    @IBAction func dateButtonTapped(_ sender: UIButton) {
        ShowDatePickerAlert(txt: paidDateTF, isMax: true)
    }
    @IBAction func imageButtonTapped(_ sender: UIButton) {
        view.endEditing(true)
        imagePicker.present(from: sender)
    }

}
enum RequestScreenType : Any{
    case edit
    case add
}
struct AddReimbursementClaimViewModel{
    var amount: String?
    var currency: String?
    var paidTo: String?
    var paidFor: String?
    var date: String?
    var images: [Image]
}
enum RequestType : Any{
    case inAdvance
    case reimbursement
}
