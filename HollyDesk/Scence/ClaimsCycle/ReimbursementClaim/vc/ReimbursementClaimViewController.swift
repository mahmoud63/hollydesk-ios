//
//  ReimbursementClaimViewController.swift
//  HollyDesk
//
//  Created by rania refaat on 11/07/2021.
//

import UIKit

class ReimbursementClaimViewController: UIViewController {

    //MARK:- outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pendingLabel: UILabel!
    @IBOutlet weak var approvedView: UIView!
    @IBOutlet weak var pendingView: UIView!
    @IBOutlet weak var deniedLabel: UILabel!
    @IBOutlet weak var approvedLabel: UILabel!
    @IBOutlet weak var deniedView: UIView!
    @IBOutlet weak var deniedButton: UIButton!
    @IBOutlet weak var approvedButton: UIButton!
    @IBOutlet weak var pendingButton: UIButton!
    
    //MARK:- variables
    let message = Messages()
    let screenTitle = ScreenTitle()
    var totalCount : Int?
    var isFetching = false
    var currentPage = 1
    var selectedIndex = -1
    var requestArray = [Request]()
    var status : RequestStatus = .pending


    //MARK:- viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = screenTitle.reimbursementClaim
        AddSwipeGesture()
    }
    
    //MARK:- viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableDesign(tvc: tableView)
        setupTableView()
        handelViewsDesign()
        getRequestsData(loading: true)
        
    }
    
    //MARK:- viewWillDisappear
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    //MARK:- setupTableView
    func setupTableView(){
        tableView.register(ReimbursementClaimTableViewCell.nib, forCellReuseIdentifier: "ReimbursementClaimTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.prefetchDataSource = self
    }
    func fillVM(data: Request)-> RequestDetailsViewModel{
        var vm = RequestDetailsViewModel()
        let submissionDate = getPaidTime(time: data.createdAt)
        let payDate = getPaidTime(time: data.paidOn)

        vm.currency = data.currency
        vm.submissionDate = submissionDate
        vm.team = data.team?.name
        vm.shortStatus = data.shortStatus
        vm.totalAmount = data.amount

        vm.images = data.images
        vm.payDate = payDate
        vm.payTo = data.paidTo
        vm.payFor = data.paidFor
        vm.requestID = data.id
        
        vm.images = data.images
        vm.status = data.status
        vm.isReceived = data.received
        vm.requestShortStatus = data.requestShortStatus
        vm.reconsileShortStatus = data.reconsileShortStatus
        
        return vm
    }
    @IBAction func addButtonAction(_ sender: UIButton) {
        let vc = AddReimbursementClaimViewController()
        vc.requestScreenType = .add
        show(vc, sender: self)
    }
    @IBAction func selectButtonAction(_ sender: UIButton) {
        
        switch sender {
        case pendingButton:
            status = .pending
            selectedIndex = 1

            handelViewsDesign()
            getRequestsData(loading: true)

        case approvedButton:
            selectedIndex = 2
            status = .approved

            handelViewsDesign()
            getRequestsData(loading: true)

        case deniedButton:
            selectedIndex = 3
            status = .declined
            handelViewsDesign()
            getRequestsData(loading: true)

        default:
            print("default")
        }
    }
}

