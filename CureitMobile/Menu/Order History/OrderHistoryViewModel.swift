//
//  OrderHistoryViewModel.swift
//  CureitMobile
//
//  Created by mac on 26/03/25.
//

import Foundation

protocol OrderHistoryViewModelDelegate: AnyObject {
    func getSettledResponse(response: SettledModel)
}
class OrderHistoryViewModel: ObservableObject {

    weak var view: OrderHistoryViewModelDelegate?
    
    init(view: OrderHistoryViewModelDelegate) {
        self.view = view
    }
    
    func getSettledOrder(vendorId: String) {
        let parameters: [String: Any] = ["vendorId": vendorId]
        NetworkManager.shared.getWithQueryParameters(endpoint: "vendor/vendorSettledOrders",parameters: parameters, responseType: SettledModel.self) { result in
            switch result {
            case .success(let success):
                self.view?.getSettledResponse(response: success)
            case .failure(let failure):
                print("Failure is \(failure)")
            }
        }
    }
    
}

extension OrderHistoryViewModel: OrderHistoryVCDelegate {
    func fetchSettledOrders(vendorId: String) {
        self.getSettledOrder(vendorId: vendorId)
    }
    
    
}
