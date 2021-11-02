//
//  HomeViewController.swift
//  HollyDesk
//
//  Created by rania refaat on 10/07/2021.
//

import UIKit

class HomeViewController: UIViewController {

    //MARK:- outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var creditLabel: UILabel!
    @IBOutlet weak var tableHeight: NSLayoutConstraint!
    @IBOutlet weak var nameLabel: UILabel!

    //MARK:- variables
    let message = Messages()
    let screenTitle = ScreenTitle()
    var totalPages : Int?
    var isFetching = false
    var currentPage = 1
    var homeRequestArray = [HomeRequest]()


    //MARK:- viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = screenTitle.home
    }
    
    //MARK:- viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableDesign(tvc: tableView)
        setupTableView()
        HideNavigationBar(status: false)
        sideNavigation()
        getHomeData()
        let name = UserDefaultData.get_user_string_data(key: UserDefaultDataKeys.firstName) ?? ""
        nameLabel.text = "Hello".localized + ", \(name)"
        
        
        let ff = "https://www.dev.hollydesk.com/createPass?id=60d2716bb4c223e0573b1ded&type=createPassword"
        
        let url = URL(string: ff)
        print(url?.scheme)
        print(url?.path)
        print(url?.pathExtension)
        print(url?.pathComponents)

    }
    //MARK:- viewWillDisappear
    func fillVM(data: HomeRequest)-> RequestDetailsViewModel{
        var vm = RequestDetailsViewModel()
        let submissionDate = getPaidTime(time: data.createdAt)
        let payDate = getPaidTime(time: data.paidOn)

        vm.currency = "EGP".localized
        vm.submissionDate = submissionDate
        vm.team = data.team
        vm.shortStatus = data.shortStatus
        vm.totalAmount = data.amount

        vm.images = data.images
        vm.payDate = payDate
        vm.payTo = data.paidTo
        vm.payFor = data.paidFor
        vm.requestID = data.id
        vm.status = data.status
        
        vm.images = data.images
        vm.isReceived = data.received
        vm.requestShortStatus = data.requestShortStatus
        vm.reconsileShortStatus = data.reconsileShortStatus
        
        return vm
    }
    //MARK:- viewWillDisappear
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        HideNavigationBar(status: true)
    }
    
    //MARK:- setupTableView
    func setupTableView(){
        tableView.register(HomeTableViewCell.nib, forCellReuseIdentifier: "HomeTableViewCell")
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
}

