//
//  IncomingViewModel.swift
//  CureitMobile
//
//  Created by mac on 22/03/25.
//

import Foundation

class IncomingViewModel: ObservableObject {
    var incomingData: IncomingOrder
    
    init(incomingData: IncomingOrder) {
        self.incomingData = incomingData
    }
    
    var orderId: String {
        return ("Order #:\(incomingData.orderId ?? "")")
    }
    
    var orderID: String {
        return incomingData.orderId
    }
}
