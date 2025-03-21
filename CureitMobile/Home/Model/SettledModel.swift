//
//  SettledModel.swift
//  CureitMobile
//
//  Created by mac on 21/03/25.
//

import Foundation

struct SettledModel: Decodable {
    let success: Bool
    let message: String
    let data: [SettledDetailModel]
}

struct SettledDetailModel: Decodable {
    let _id: String
    let orderId: String
    let products: [SettledProducts]
    let totalAmount: Int
    let createdAt: String
    let __v: Int
}

struct SettledProducts: Decodable {
    let productId: String
    let quantity: Int
    let _id: String
}
