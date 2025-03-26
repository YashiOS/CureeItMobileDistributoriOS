//
//  IncomeDetailsViewModel.swift
//  CureitMobile
//
//  Created by Gagan Pareek on 22/03/25.
//

import Foundation

class IncomeDetailsViewModel: ObservableObject {
    var incomeData: IncomeDetailsData
    
    init(incomeData: IncomeDetailsData) {
        self.incomeData = incomeData
    }
    var orderId: String {
        return ("Order #:\(incomeData.orderId ?? "")")
    }
    
    var totalAmount: String {
        return "Order Total: ₹\(incomeData.totalAmount ?? 0)"
    }

}

