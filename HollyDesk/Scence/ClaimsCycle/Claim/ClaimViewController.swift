//
//  ClaimViewController.swift
//  HollyDesk
//
//  Created by rania refaat on 10/07/2021.
//

import UIKit

class ClaimViewController: UIViewController {

    //MARK:- outlets
    @IBOutlet var arrowImages: [UIImageView]!{
        didSet{
            if L102Language.isRTL {
                arrowImages.forEach({
                    $0.transform = CGAffineTransform(scaleX: -1, y: 1)
                })
            }
        }
    }
    
    //MARK:- variables
    let message = Messages()
    let screenTitle = ScreenTitle()

    //MARK:- viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = screenTitle.claims
    }
    override func viewWillAppear(_ animated: Bool) {
        sideNavigation()
    }
    @IBAction func reimbursementSelected(_ sender: UIButton) {
        show(ReimbursementClaimViewController(), sender: self)

    }
    
    @IBAction func advanceSelected(_ sender: UIButton) {
        show(AdvanceClaimViewController(), sender: self)
    }
    
    
}
