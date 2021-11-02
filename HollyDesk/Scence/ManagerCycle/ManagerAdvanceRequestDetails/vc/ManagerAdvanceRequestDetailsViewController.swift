//
//  ManagerAdvanceRequestDetailsViewController.swift
//  HollyDesk
//
//  Created by rania refaat on 02/10/2021.
//

import UIKit
import SSSpinnerButton

class ManagerAdvanceRequestDetailsViewController: UIViewController {

    @IBOutlet weak var servicePaidForLabel: UILabel!
    @IBOutlet weak var submissionDateLabel: UILabel!
    @IBOutlet weak var paidOnDateLabel: UILabel!
    @IBOutlet weak var fromUserTeamLabel: UILabel!
    @IBOutlet weak var fromUserImageView: UIImageView!
    @IBOutlet weak var fromUserNameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableHeight: NSLayoutConstraint!
    @IBOutlet weak var attachmentLabel: UILabel!
    @IBOutlet weak var actionsStack: UIStackView!
    
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var toUserImageView: UIImageView!
    @IBOutlet weak var toUserNameLabel: UILabel!

    @IBOutlet weak var acceptButton: SSSpinnerButton!
    @IBOutlet weak var cancelButton: SSSpinnerButton!

    //MARK:- variables
    let message = Messages()
    let screenTitle = ScreenTitle()
    var request: ManagerRequestDetailsViewModel?
    var requestID = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = screenTitle.requestDetails
        setupTableView()
        getRequestsDetails()
        setImagesDesign()
    }
    
    //MARK:- setupTableView
    func setupTableView(){
        tableView.register(ManagerAdvanceRequestDetailsTableViewCell.nib, forCellReuseIdentifier: "ManagerAdvanceRequestDetailsTableViewCell")
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
    private func setImagesDesign(){
        toUserImageView.layer.cornerRadius = 8
        toUserImageView.layer.borderWidth = 0.8
        toUserImageView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        fromUserImageView.layer.cornerRadius = 8
        fromUserImageView.layer.borderWidth = 0.8
        fromUserImageView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    }
    //MARK:- setData
    func setData(){
        let currency = request?.currency ?? ""
        let amount = "\(request?.totalAmount ?? 0)"
        let submissionDate = request?.submissionDate
        let payDate = request?.payDate

        totalAmountLabel.text = amount + " " + "EGP".localized
        submissionDateLabel.text = submissionDate
        paidOnDateLabel.text = payDate
        servicePaidForLabel.text = request?.payFor

        fromUserTeamLabel.text = request?.fromUserTeam ?? ""
        fromUserNameLabel.text = request?.fromUserName ?? ""
        
        fromUserImageView.loadImageUrl(request?.fromUserImage)
        
        toUserImageView.loadImageUrl(request?.toUserImage)
        
        toUserNameLabel.text = request?.toUserName

        if request?.images?.count ?? 0 == 0 {
            attachmentLabel.isHidden = true
        }else{
            attachmentLabel.isHidden = false
        }
        print(request?.images?.count ?? 0)
        tableView.reloadData()

        switch request?.shortStatus {
        case .Pending , .pending:
            actionsStack.isHidden = false
        default:
            actionsStack.isHidden = true
        }
        
    }
    @IBAction func denyButtonTapped(_ sender: UIButton) {
        requestActionDetails(type: "deny")
    }
    @IBAction func acceptButtonTapped(_ sender: UIButton) {
        requestActionDetails(type: "accept")
    }
    
}
