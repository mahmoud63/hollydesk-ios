//
//  HomeModel.swift
//  HollyDesk
//
//  Created by rania refaat on 14/07/2021.
//

import Foundation

// MARK: - HomeModel
struct HomeModel: Codable {
    let status: Int?
    let message: String?
    let data: HomeModelData?
}

// MARK: - HomeModelData
struct HomeModelData: Codable {
    let credit: Int?
    let requests: [HomeRequest]?
}

// MARK: - HomeRequest
struct HomeRequest: Codable {
    let id: String?
    let images: [Image]?
    let paidTo, paidFor, paidOn, number: String?
    let amount: Double?
    let status: String?
    let new: Bool?
    let shortStatus: RequestStatus?
    let received: Bool?
    let currency: String?
    let requestType: String?
    let team: String?
    let requestShortStatus: Int?
    let reconsileShortStatus: Int?
    let createdAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case images, paidTo, paidFor, paidOn, number, amount, status, new , currency, requestType , team , createdAt
        case shortStatus = "short_status"
        case received,requestShortStatus,reconsileShortStatus
        
    }
}

// MARK: - Image
struct Image: Codable {
    let id, name: String?
    let path: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, path
    }
}
enum RequestStatus: String, Codable {
    case non = ""
    case pending = "pending"
    case approved = "approved"
    case declined = "declined"
    case reconciliationApproved = "reconciliation approved"
    
    case ReconciliationApproved = "Reconciliation approved"
    case Pending = "Pending"
    case Declined = "Declined"
    case Approved = "Approved"

    var title: String {
        switch self {
        case .pending:
            return "pending"
        case .approved:
            return "approved"
        case .declined:
            return "declined"
        case .reconciliationApproved:
            return "reconciliation approved"
        case .ReconciliationApproved:
            return "Reconciliation approved"
        case .Pending:
            return "Pending"
        case .Declined:
            return "Declined"
        case .Approved:
            return "Approved"

        case .non:
            return ""
        }
    }
    
    var arTitle: String {
        switch self {
        case .pending:
            return "pending".localized
        case .approved:
            return "approved".localized
        case .declined:
            return "declined".localized
        case .reconciliationApproved:
            return "reconciliation approved".localized
        case .ReconciliationApproved:
            return "Reconciliation approved".localized
        case .Pending:
            return "Pending".localized
        case .Declined:
            return "Declined".localized
        case .Approved:
            return "Approved".localized

        case .non:
            return ""
        }
    }
}
