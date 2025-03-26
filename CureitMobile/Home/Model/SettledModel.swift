//
//  SettledModel.swift
//  CureitMobile
//
//  Created by mac on 21/03/25.

import Foundation

struct SettledDetailModel : Codable {
    let _id : String?
    let vendorId : String?
    let orderId : String?
    let products : [SettledProducts]?
    let totalAmount : String?
    let deliveredAt: String?
    let __v : Int?

    enum CodingKeys: String, CodingKey {

        case _id = "_id"
        case vendorId = "vendorId"
        case orderId = "orderId"
        case products = "products"
        case totalAmount = "totalAmount"
        case deliveredAt = "deliveredAt"
        case __v = "__v"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _id = try values.decodeIfPresent(String.self, forKey: ._id)
        vendorId = try values.decodeIfPresent(String.self, forKey: .vendorId)
        orderId = try values.decodeIfPresent(String.self, forKey: .orderId)
        products = try values.decodeIfPresent([SettledProducts].self, forKey: .products)
        totalAmount = try values.decodeIfPresent(String.self, forKey: .totalAmount)
        deliveredAt = try values.decodeIfPresent(String.self, forKey: .deliveredAt)
        __v = try values.decodeIfPresent(Int.self, forKey: .__v)
    }

}

struct SettledModel : Codable {
    let success : Bool?
    let message : String?
    let data : [SettledDetailModel]?

    enum CodingKeys: String, CodingKey {

        case success = "success"
        case message = "message"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent([SettledDetailModel].self, forKey: .data)
    }
}

struct SettledProducts : Codable {
    let productId : String?
    let quantity : Int?
    let productName: String?
    let productPrice: String?
    let productMarketer: String?
    let imageUrls: [String]?
    let _id : String?
}
