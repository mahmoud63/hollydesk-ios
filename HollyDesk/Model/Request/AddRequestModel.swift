//
//  AddRequestModel.swift
//  HollyDesk
//
//  Created by rania refaat on 21/07/2021.
//

import Foundation

// MARK: - AddRequestImageModel
struct AddRequestImageModel: Codable {
    let status: Int?
    let message: String?
    let data: [Image]?
}

//// MARK: - AddRequestImageModelData
//struct AddRequestImageModelData: Codable {
//    let id: String?
//    let path: String?
//    let name: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id = "_id"
//        case path, name
//    }
//}
// MARK: - AddRequestModel
struct AddRequestModel: Codable {
    let status: Int?
    let message: String?
//    let data: String?
}
