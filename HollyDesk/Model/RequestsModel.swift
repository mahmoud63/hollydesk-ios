//
//  RequestsModel.swift
//  HollyDesk
//
//  Created by rania refaat on 16/07/2021.
//

import Foundation

// MARK: - RequestsModel
struct RequestsModel: Codable {
    let status: Int?
    let message: String?
    let data: RequestsModelData?
}

// MARK: - DataClass
struct RequestsModelData: Codable {
    let requests: [Request]?
    let count, totalCount: Int?
}

// MARK: - Request
struct Request: Codable {
    let images: [Image]?
    let id, paidTo, paidFor, paidOn: String?
    let number: String?
    let amount: Double?
    let currency, status, createdAt: String?
    let new: Bool?
    let requestID: String?
    var shortStatus: RequestStatus?
    let requestShortStatus: Int?
    let reconsileShortStatus: Int?
    let requestType: String?
    let team: RequestTeam?
    let received: Bool?
    
    enum CodingKeys: String, CodingKey {
        case images
        case id = "_id"
        case paidTo, paidFor, paidOn, number, amount, currency, status, createdAt, new
        case shortStatus = "short_status"
        case requestID = "id"
        case requestShortStatus
        case requestType
        case team , received
        case reconsileShortStatus
    }
}
struct RequestTeam: Codable {
    let name: String?

}
