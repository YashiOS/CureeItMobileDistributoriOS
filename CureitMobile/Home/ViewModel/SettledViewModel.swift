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
        return ("Order #:\(settledData.orderId ?? "")")
    }
    
    var totalAmount: String {
        return "Order Total: ₹\(settledData.totalAmount ?? "")"
    }
    
    var orderAmount: String {
        return ("₹\(settledData.totalAmount ?? "")")
    }
    
    var deliveredAt: String {
        return settledData.deliveredAt ?? ""
    }
    
    var discountPrice: String {
        guard let priceString = settledData.totalAmount,
              let price = Double(priceString) else { return "₹0.00" }
        let discount = price * 0.30
        return "₹\(String(format: "%.2f", discount))"
    }
    
    var taxAndServices: String {
        guard let priceString = settledData.totalAmount,
              let price = Double(priceString) else { return "₹0.00" }
        let tax = price * 0.18
        return "₹\(String(format: "%.2f", tax))"
    }
    
}
