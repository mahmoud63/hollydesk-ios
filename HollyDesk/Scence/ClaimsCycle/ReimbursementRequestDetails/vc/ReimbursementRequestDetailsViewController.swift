//
//  ReimbursementRequestDetailsViewController.swift
//  HollyDesk
//
//  Created by rania refaat on 28/08/2021.
//

import UIKit

class ReimbursementRequestDetailsViewController: UIViewController {


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
    @IBOutlet weak var attachmentLabel: UILabel!
    
    //MARK:- variables
    let message = Messages()
    let screenTitle = ScreenTitle()
    var request: RequestDetailsViewModel?
    var requestType : RequestType?
    var requestID = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = screenTitle.requestDetails
        setupTableView()
        getRequestsDetails()
    }
    //MARK:- setupTableView
    func setupTableView(){
        tableView.register(ReimbursementRequestDetailsTableViewCell.nib, forCellReuseIdentifier: "ReimbursementRequestDetailsTableViewCell")
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
        
        tableView.reloadData()
        
        if request?.shortStatus ?? .pending == .pending {
            editButton.isHidden = false
        }else{
            editButton.isHidden = true

        }
        if request?.images?.count ?? 0 == 0 {
            attachmentLabel.isHidden = true
        }else{
            attachmentLabel.isHidden = false
        }
    }
    @IBAction func editButtonTapped(_ sender: Any) {
        switch requestType {
        case .inAdvance:
            let vc = AddAdvanceClaimViewController()
            vc.requestScreenType = .edit
            vc.requestVM = request
            show(vc, sender: self)
        case .reimbursement:
            let vc = AddReimbursementClaimViewController()
            vc.requestScreenType = .edit
            vc.requestVM = request
            show(vc, sender: self)
        default:
            break
        }
    }
    
}
struct RequestDetailsViewModel{
    var submissionDate: String?
    var team: String?
    var status: String?
    var totalAmount: Double?
    var payDate: String?
    var payTo: String?
    var payFor: String?
    var requestID: String?
    var currency: String?
    var images: [Image]?
    var shortStatus: RequestStatus?
    var isReceived: Bool?
    var requestShortStatus: Int?
    var reconsileShortStatus: Int?
}
struct ManagerRequestDetailsViewModel{
    var fromUserImage: String?
    var fromUserName: String?
    var fromUserTeam: String?
    
    var toUserImage: String?
    var toUserName: String?
//    var toUserTeam: String?
    
    var payDate: String?
    var submissionDate: String?
    var payFor: String?
    var images: [Image]?
    var requestID: String?
    var shortStatus: RequestStatus?
    
    var currency: String?
    var totalAmount: Double?

}
