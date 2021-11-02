//
//  WalletTypeModel.swift
//  HollyDesk
//
//  Created by rania refaat on 23/07/2021.
//

import Foundation

// MARK: - WalletTypeModel
struct WalletTypeModel: Codable {
    let status: Int?
    let message: String?
    let data: WalletTypeModelData?
}

// MARK: - WalletTypeModelData
struct WalletTypeModelData: Codable {
    let id: String?
    let wallets: [WalletTypeModelWallet]?
    let v: Int?
    let dataID: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case wallets
        case v = "__v"
        case dataID = "id"
    }
}

// MARK: - WalletTypeModelWallet
struct WalletTypeModelWallet: Codable {
    let id, name: String?
    let image: String?
    let type: WalletType?
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, type, image
    }
}

enum WalletType: String, Codable {
    case non = ""
    case bank = "BANK"
    case eWallet = "EWALLET"
    
    var title: String {
        switch self {
        case .bank:
            return "BANK".localize
        case .eWallet:
            return "EWALLET".localize
        case .non:
            return ""
        }
    }
}

// MARK: - cashOutModel
struct cashOutModel: Codable {
    let status: Int?
    let message: String?
    let data: Int?
}
