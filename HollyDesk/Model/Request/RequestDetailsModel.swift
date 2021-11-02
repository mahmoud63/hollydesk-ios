//
//  RequestDetailsModel.swift
//  HollyDesk
//
//  Created by rania refaat on 02/10/2021.
//

import Foundation
// MARK: - HomeModel
struct RequestDetailsModel: Codable {
    let status: Int?
    let message: String?
    let data: RequestDetailsModelData?
}
// MARK: - RequestDetailsModelData
struct RequestDetailsModelData: Codable {
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
    let requestShortStatus: Int?
    let reconsileShortStatus: Int?
    let createdAt: String?
    let from: RequestDetailsFromModelData?
    let team: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case images, paidTo, paidFor, paidOn, number, amount, status, new , currency, requestType , team , createdAt
        case shortStatus = "short_status"
        case received,requestShortStatus,reconsileShortStatus, from
        
    }
}
// MARK: - RequestDetailsFromModelData
struct RequestDetailsFromModelData: Codable {
    let firstName: String?
    let image: Image?
    let lastName: String?
    
    enum CodingKeys: String, CodingKey {
        case firstName , lastName , image
    }
}
// MARK: - RequestDetailsFromModelData
struct RequestDetailsTeamModelData: Codable {
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case name
    }
}
