//
//  IncomingOrdersDetailsViewModel.swift
//  CureitMobile
//
//  Created by mac on 23/03/25.
//
import Foundation

class IncomingOrdersDetailsViewModel: ObservableObject {
    var orderedItem: IncomingOrderItem
    
    init(orderedItem: IncomingOrderItem) {
        self.orderedItem = orderedItem
    }
    
    var productId: String {
        return orderedItem.productId
    }
    var drugName: String {
        return orderedItem.productName
    }
    var drugQuantity: Int {
        return orderedItem.quantity
    }
    var drugPrice: String {
        return orderedItem.productPrice
    }
    var drugImages: String {
        return orderedItem.productImages[0]
    }
    var drugMarketer: String {
        return orderedItem.productMarketer
    }
    
}
