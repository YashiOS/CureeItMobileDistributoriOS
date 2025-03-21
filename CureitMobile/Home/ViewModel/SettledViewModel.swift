//
//  SettledViewModel.swift
//  CureitMobile
//
//  Created by mac on 21/03/25.
//
import Foundation

class SettledViewModel: ObservableObject {
    var settledData: SettledDetailModel
    
    init(settledData: SettledDetailModel) {
        self.settledData = settledData
    }
    var orderId: String {
        return ("Order #:\(settledData.orderId)")
    }
    
    var totalAmount: String {
        return "Order Total: ₹\(settledData.totalAmount)"
    }
    var createAt: String {
        return settledData.createdAt
    }
}
