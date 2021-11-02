//
//  UserDataModel.swift
//  HollyDesk
//
//  Created by rania refaat on 12/07/2021.
//

import Foundation

// MARK: - UserModel
struct UserModel: Codable {
    let status: Int?
    let message: String?
    let data: UserModelData?
}

// MARK: - UserModelData
struct UserModelData: Codable {
    let user: User?
    var token: String?
}

// MARK: - User
struct User: Codable {
    let firstName, role, lastName, email: String?
    let phone: [String]?
    let credit: Int?
    let jobTitle: String?
    let image: String?
    let company, team: Company?
}

// MARK: - Company
struct Company: Codable {
    let name, id: String?
}
// MARK: - UserProfileModel
struct UserProfileModel: Codable {
    let status: Int?
    let message: String?
    let data: UserProfileModelData?
}

// MARK: - UserModelData
struct UserProfileModelData: Codable {
    var token: String?
    let firstName, role, lastName, email: String?
    let phone: [String]?
    let credit: Int?
    let jobTitle: String?
    let image: String?
    let company, team: Company?
}
