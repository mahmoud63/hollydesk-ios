//
//  InAdvanceRequestDetailsViewController.swift
//  HollyDesk
//
//  Created by rania refaat on 28/08/2021.
//

import UIKit
import SSSpinnerButton
class InAdvanceRequestDetailsViewController: UIViewController {
    
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var submissionDateLabel: UILabel!
    @IBOutlet weak var servicePaidForLabel: UILabel!
    @IBOutlet weak var paidToLabel: UILabel!
    @IBOutlet weak var payDateLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var teamLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableHeight: NSLayoutConstraint!
    @IBOutlet weak var receiptUploadLabel: UILabel!
    @IBOutlet weak var draftButton: SSSpinnerButton!
    @IBOutlet weak var submitButton: SSSpinnerButton!
    @IBOutlet weak var uploadImageView: UIView!

    //MARK:- variables
    let message = Messages()
    let screenTitle = ScreenTitle()
    var request: RequestDetailsViewModel?
    var requestType : RequestType?
    var imagePicker : ImagePicker!
    var selectedImages = [Image]()
    var requestID = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = screenTitle.requestDetails
        setupTableView()
        imagePicker = ImagePicker(presentationController: self, delegate: self)
        getRequestsDetails()
    }
    //MARK:- setupTableView
    func setupTableView(){
        tableView.register(InAdvanceRequestDetailsTableViewCell.nib, forCellReuseIdentifier: "InAdvanceRequestDetailsTableViewCell")
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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        HideNavigationBar(status: false)
    }
    //MARK:- setData
    func setData(){
        let currency = request?.currency ?? ""
        let amount = "\(request?.totalAmount ?? 0)"
        let submissionDate = request?.submissionDate
        let payDate = request?.payDate
        
        totalAmountLabel.text = amount + " " + "EGP".localized
        submissionDateLabel.text = submissionDate
        payDateLabel.text = payDate
        servicePaidForLabel.text = request?.payFor
        teamLabel.text = request?.team
        statusLabel.text = request?.status
        paidToLabel.text = request?.payTo
                
        if request?.shortStatus ?? .pending == .pending {
            editButton.isHidden = false
            uploadImageView.isHidden = true
            receiptUploadLabel.isHidden = true

        }else{
            editButton.isHidden = true
            uploadImageView.isHidden = false
            receiptUploadLabel.isHidden = false
        }

        selectedImages = request?.images ?? []
        tableView.reloadData()

        let requestStatus = request?.requestShortStatus ?? 0
        let consilStatus = request?.reconsileShortStatus ?? 0
        
        hideAttachmentStatus(request: requestStatus, coil: consilStatus)
        hideConfirmStatus(request: requestStatus, coil: consilStatus)
        
    }
    private func hideAttachmentStatus(request: Int, coil: Int){
        if (request == 1 && coil == 0){
            draftButton.isHidden = false
        } else if (request == 1 && coil == -1){
            draftButton.isHidden = false
        }else if (request == 1 && coil == -3){
            draftButton.isHidden = false
        }else {
            draftButton.isHidden = true
        }
    }
    private func hideConfirmStatus(request: Int, coil: Int){
        if (request == -1 || request == 0){
            submitButton.isHidden = true
            uploadImageView.isHidden = true
            receiptUploadLabel.isHidden = true
        } else if (request == 1 && coil == 2){
            submitButton.isHidden = true
            uploadImageView.isHidden = true
            receiptUploadLabel.isHidden = true
        }else if (request == 1 && coil == 1){
            submitButton.isHidden = true
            uploadImageView.isHidden = true
            receiptUploadLabel.isHidden = true
        }else {
            submitButton.isHidden = false
        }
    }
    
    
    @IBAction func imageButtonTapped(_ sender: UIButton) {
        view.endEditing(true)
        imagePicker.present(from: sender)
    }
    @IBAction func editButtonTapped(_ sender: Any) {
        let vc = AddAdvanceClaimViewController()
        vc.requestScreenType = .edit
        vc.requestVM = request
        show(vc, sender: self)
    }
    @IBAction func draftButtonTapped(_ sender: Any) {
        if selectedImages.count == 0 {
            showMessage(sub: message.paidImagesMessage)
        }else{
            var params = ["_id":request?.requestID ?? "0",
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
            DraftRequestImages(parameters: params)
        }
    }
    @IBAction func submitButtonTapped(_ sender: Any) {

            var params = ["_id":request?.requestID ?? "0",
                              "note":"",
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
        SubmitRequestImages(parameters: params)
    }

}
