//
//  IncomeModel.swift
//  CureitMobile
//
//  Created by Gagan Pareek on 22/03/25.
//

import Foundation

struct IncomeDetailsData : Codable {
    let orderId : String?
    let totalAmount : Double?
    let deliveredAt: String?
    enum CodingKeys: String, CodingKey {

        case orderId = "orderId"
        case totalAmount = "totalAmount"
        case deliveredAt = "deliveredAt"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        orderId = try values.decodeIfPresent(String.self, forKey: .orderId)
        totalAmount = try values.decodeIfPresent(Double.self, forKey: .totalAmount)
        deliveredAt = try values.decodeIfPresent(String.self, forKey: .deliveredAt)
    }

}

struct IncomeDetails : Codable {
    let success : Bool?
    let message : String?
    let totalAmount: String?
    let data : [IncomeDetailsData]?

    enum CodingKeys: String, CodingKey {

        case success = "success"
        case message = "message"
        case totalAmount = "totalAmount"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        totalAmount = try values.decodeIfPresent(String.self, forKey: .totalAmount)
        data = try values.decodeIfPresent([IncomeDetailsData].self, forKey: .data)
    }

}
