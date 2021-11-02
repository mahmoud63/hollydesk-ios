//
//  URLs.swift
//  Detailes
//
//  Created by MacBook on 12/28/19.
//  Copyright © 2019 Rania. All rights reserved.
//

import Foundation
struct URLS {
    
    //MARK: - MAIN URL
    static let main = "https://dev.hollydesk.com/api/v1/"
    
}//end of URLS

public enum BaseURL: String {
    case staging = "https://dev.hollydesk.com/api/v1/"
    case live = "http:"
}

public enum ServiceName: String {
    case login = "auth/login"
    case home = "dashboard/homeRequests"
    case requests = "requests/my-requests"
    case inadvanceRequests = "inadvance/my-request"
    case addImageRequest = "upload/images?type=requests"
    case addRequest = "requests/add-request"
    case walletType = "user/walletTypes"
    case cashOut = "user/cashout"
    case addInAdvanceRequest = "inadvance/request"
    case editInAdvanceRequest = "inadvance/editRequest"
    case editIReimbursementRequest = "requests/editRequest"
    case inAdvanceDraftImages = "inadvance/draft-request"
    case inAdvanceSubmitImages = "inadvance/reconsile-request"
    case managerRequest = "requests"
    case managerInAdvanceRequest = "inadvance"

    
    case managerAcceptReimbursement = "requests/approve-manager"
    case managerDenyReimbursement = "requests/decline-manager"
    
    case managerAcceptAdvance = "inadvance/approve-manager"
    case managerDenyAdvance = "inadvance/decline-manager"

    case profile = "user/profile"

}
