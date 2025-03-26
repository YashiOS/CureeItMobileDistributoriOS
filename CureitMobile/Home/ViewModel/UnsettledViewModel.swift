//
//  UnsettledViewModel.swift
//  CureitMobile
//
//  Created by Gagan Pareek on 22/03/25.
//

import Foundation

class UnSettledViewModel: ObservableObject {
    var unsettledData: UnsettledDetailModel
    
    init(unsettledData: UnsettledDetailModel) {
        self.unsettledData = unsettledData
    }
    var orderId: String {
        return ("Order #:\(unsettledData.orderId ?? "")")
    }
    
    var totalAmount: String {
        return "Order Total: ₹\(unsettledData.totalAmount ?? "")"
    }
    
   
    var createAt: String {
        return unsettledData.createdAt ?? ""
    }
}
