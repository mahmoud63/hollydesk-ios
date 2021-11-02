//
//  Swiper+ReimbursementClaim.swift
//  HollyDesk
//
//  Created by rania refaat on 11/07/2021.
//

import Foundation
import UIKit

extension ReimbursementClaimViewController{
    // MARK: - AddSwipeGesture
    func AddSwipeGesture(){
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)

        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
    }
    // MARK: - handelViewsDesign
    func handelViewsDesign(){
        switch selectedIndex {
        case 1:
            pendingView.backgroundColor = AppColor.MainBlack
            pendingLabel.textColor = AppColor.MainWhite
            approvedView.backgroundColor = AppColor.MainWhite
            approvedLabel.textColor = AppColor.MainDarkBlack
            deniedView.backgroundColor = AppColor.MainWhite
            deniedLabel.textColor = AppColor.MainDarkBlack
            status = .pending
            getRequestsData(loading: true)

        case 2:
            pendingView.backgroundColor = AppColor.MainWhite
            pendingLabel.textColor = AppColor.MainDarkBlack
            approvedView.backgroundColor = AppColor.MainBlack
            approvedLabel.textColor = AppColor.MainWhite
            deniedView.backgroundColor = AppColor.MainWhite
            deniedLabel.textColor = AppColor.MainDarkBlack
            status = .approved
            getRequestsData(loading: true)

        case 3:
            pendingView.backgroundColor = AppColor.MainWhite
            pendingLabel.textColor = AppColor.MainDarkBlack
            approvedView.backgroundColor = AppColor.MainWhite
            approvedLabel.textColor = AppColor.MainDarkBlack
            deniedView.backgroundColor = AppColor.MainBlack
            deniedLabel.textColor = AppColor.MainWhite
            status = .declined
            getRequestsData(loading: true)

        default:
            print(selectedIndex)
        }

    }
    // MARK: - handleGesture
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
       if gesture.direction == .right {
        if selectedIndex != 1 {
            selectedIndex -= 1
        }
        handelViewsDesign()
       }
       else if gesture.direction == .left {
        if selectedIndex != 4 {
            selectedIndex += 1
        }
        handelViewsDesign()

       }
    }
}
