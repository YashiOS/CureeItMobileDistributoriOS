//
//  AcceptOrderModel.swift
//  CureitMobile
//
//  Created by Gagan Pareek on 22/03/25.
//

import Foundation

struct AcceptOrderRequest: Encodable {
    let orderId: String
    let vendorId: String
    let acceptedItems: [String]
    let rejectedItems: [String]
}

struct AcceptOrderResponse: Codable {
    let success: Bool
    let message: String
    let orderId: String
    let acceptedItemsCount: Int
    let rejectedItemsCount: Int
    let data: AcceptOrderData
}

struct AcceptOrderData: Codable {
    let vendorId: String
    let orderId: String
    let products: [AcceptedProduct]
    let totalAmount: Double
    let status: String
    let partialAcceptance: Bool
    let rejectedProducts: [AcceptedProduct]
    let deliveredAt: String?
    let id: String
    let createdAt: String
    let v: Int
    
    enum CodingKeys: String, CodingKey {
        case vendorId, orderId, products, totalAmount, status, partialAcceptance, rejectedProducts, deliveredAt
        case id = "_id"
        case createdAt, v = "__v"
    }
}

struct AcceptedProduct: Codable {
    let productId: String
    let productName: String
    let productPrice: String
    let productMarketer: String
    let quantity: Int
    let id: String
    
    enum CodingKeys: String, CodingKey {
        case productId, productName, productPrice, productMarketer, quantity
        case id = "_id"
    }
}
