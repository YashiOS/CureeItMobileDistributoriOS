//
//  UnsettledModel.swift
//  CureitMobile
//
//  Created by Gagan Pareek on 22/03/25.
//

import Foundation

struct UnsettledDetailModel : Codable {
    let _id : String?
    let vendorId : String?
    let orderId : String?
    let products : [UnsettledProducts]?
    let totalAmount : String?
    let createdAt : String?
    let __v : Int?

    enum CodingKeys: String, CodingKey {

        case _id = "_id"
        case vendorId = "vendorId"
        case orderId = "orderId"
        case products = "products"
        case totalAmount = "totalAmount"
        case createdAt = "createdAt"
        case __v = "__v"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _id = try values.decodeIfPresent(String.self, forKey: ._id)
        vendorId = try values.decodeIfPresent(String.self, forKey: .vendorId)
        orderId = try values.decodeIfPresent(String.self, forKey: .orderId)
        products = try values.decodeIfPresent([UnsettledProducts].self, forKey: .products)
        totalAmount = try values.decodeIfPresent(String.self, forKey: .totalAmount)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        __v = try values.decodeIfPresent(Int.self, forKey: .__v)
    }

}

struct UnsettledModel : Codable {
    let success : Bool?
    let message : String?
    let data : [UnsettledDetailModel]?

    enum CodingKeys: String, CodingKey {

        case success = "success"
        case message = "message"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent([UnsettledDetailModel].self, forKey: .data)
    }
}

struct UnsettledProducts : Codable {
    let productId : String?
    let quantity : Int?
    let productName: String?
    let productPrice: String?
    let productMarketer: String?
    let imageUrls: [String]?
    let _id : String?
}
