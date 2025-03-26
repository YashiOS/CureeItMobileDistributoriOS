//
//  U.swift
//  CureitMobile
//
//  Created by mac on 23/03/25.
//

import Foundation

class UnSettledDetailsViewModel: ObservableObject {
    var unSettledProducts: UnsettledProducts
    
    init(unSettledProducts: UnsettledProducts) {
        self.unSettledProducts = unSettledProducts
    }
    
    var drugName: String {
        return unSettledProducts.productName ?? ""
    }
    
    var drugMarketer: String {
        return unSettledProducts.productMarketer ?? ""
    }
    
    var drugPrice: String {
        return unSettledProducts.productPrice ?? ""
    }
    
    var imageUrl: String {
        return unSettledProducts.imageUrls?[0] ?? ""
    }
    
    var drugQuantity: Int {
        return unSettledProducts.quantity ?? 0
    }
    
}
