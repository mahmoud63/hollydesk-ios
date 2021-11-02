//
//  AddAdvanceClaimViewController.swift
//  HollyDesk
//
//  Created by rania refaat on 13/08/2021.
//

import UIKit
import SSSpinnerButton
import SwiftyJSON

class AddAdvanceClaimViewController: UIViewController {

    @IBOutlet weak var currencyTF: UITextField!
    @IBOutlet weak var totalAmountTF: UITextField!
    @IBOutlet weak var paidToTF: UITextField!
    @IBOutlet weak var paidDateTF: UITextField!
    @IBOutlet weak var confirmButton: SSSpinnerButton!
    @IBOutlet weak var paidForTF: UITextField!

    //MARK:- variables
    let message = Messages()
    let screenTitle = ScreenTitle()
    var imagePicker : ImagePicker!
    var requestScreenType: RequestScreenType?
    var requestVM : RequestDetailsViewModel?

    //MARK:- viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTF()
        textFieldImage()
        currencyTF.text = "EGP".localized
        currencyTF.isEnabled = false
        title = screenTitle.advanceRequest
    }
    
    //MARK:- viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if requestScreenType == .edit {
            setEditData()
        }else if requestScreenType == .add {
        }
    }
    
    //MARK:- setEditData
    func setEditData(){
        currencyTF.text = "EGP".localized//requestVM?.currency
        totalAmountTF.text = "\(Int(requestVM?.totalAmount ?? 0))"
        paidToTF.text = requestVM?.payTo
        paidForTF.text = requestVM?.payFor
        paidDateTF.text = requestVM?.payDate
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

    @IBAction func confirmButtonTapped(_ sender: SSSpinnerButton) {
        let amount = totalAmountTF.text!
        let currency = currencyTF.text!
        let paidTo = paidToTF.text!
        let paidFor = paidForTF.text!
        let paidDate = paidDateTF.text!
        
        if isNotEmptyString(text: amount, withAlertMessage: message.amountMessage) && isNotEmptyString(text:currency, withAlertMessage: message.currencyMessage) && isNotEmptyString(text: self.paidToTF.text!, withAlertMessage: message.paidToMessage) && isNotEmptyString(text: paidFor, withAlertMessage: message.paidForMessage) && isNotEmptyString(text: paidDate, withAlertMessage: message.paidDateMessage){
                var params = ["amount":amount,
                              "currency":currency,
                              "paidTo":paidTo,
                              "paidFor":paidFor,
                              "date": paidDate,
                ]as[String:AnyObject]
            
            switch self.requestScreenType {
            case .edit:
                params["id"] = requestVM?.requestID as AnyObject?
            default:
                break
            }
                AddRequest(parameters: params)
            }
            
        
    }
    @IBAction func dateButtonTapped(_ sender: UIButton) {
        ShowDatePickerAlert(txt: paidDateTF, isMax: false)
    }
}
