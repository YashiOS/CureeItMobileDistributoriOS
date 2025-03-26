//
//  OrderListViewModel.swift
//  CureitMobile
//
//  Created by mac on 24/03/25.
//

import Foundation

class OrderListDetailsViewModel: ObservableObject {
    var settledProducts: SettledProducts
    
    init(settledProducts: SettledProducts) {
        self.settledProducts = settledProducts
    }
    
    var drugName: String {
        return settledProducts.productName ?? ""
    }
    
    var drugQuantity: Int {
        return settledProducts.quantity ?? 0
    }
    
    var drugPrice: String {
        return ("₹\(settledProducts.productPrice ?? "")")
    }
    
    var discountPrice: String {
        guard let priceString = settledProducts.productPrice,
              let price = Double(priceString) else { return "₹0.00" }
        let discount = price * 0.30
        return "₹\(String(format: "%.2f", discount))"
    }
    
    var taxAndServices: String {
        guard let priceString = settledProducts.productPrice,
              let price = Double(priceString) else { return "₹0.00" }
        let tax = price * 0.18
        return "₹\(String(format: "%.2f", tax))"
    }
}
