//
//  IncomingOrderModel.swift
//  CureitMobile
//
//  Created by mac on 22/03/25.
//

import Foundation

struct IncomingOrdersResponse: Codable {
    let success: Bool
    let message: String
    let data: [IncomingOrder]
}

struct IncomingOrder: Codable {
    let paymentDetails: PaymentDetails
    let id: String?
    let orderId: String
    let userId: String
    let purchaseDate: String
    let currentStatus: String
    let orderItems: [IncomingOrderItem]
    let totalAmount: String
    let shippingAddress: String
    let shippingCost: Double
    let acceptedByVendorId: String?
    let createdAt: String?
    let updatedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case paymentDetails
        case id = "_id"
        case orderId, userId, purchaseDate, currentStatus, orderItems, totalAmount, shippingAddress, shippingCost, acceptedByVendorId, createdAt, updatedAt
    }
}

struct PaymentDetails: Codable {
    let gateway: String
    let transactionId: String
    let status: String
}

struct IncomingOrderItem: Codable {
    let productId: String
    let quantity: Int
    let id: String?
    let productName: String
    let productPrice: String
    let productMarketer: String
    let productImages: [String]
    
    enum CodingKeys: String, CodingKey {
        case productId, quantity, productName, productPrice, productMarketer
        case id = "_id"
        case productImages = "imageUrls"
    }
}

