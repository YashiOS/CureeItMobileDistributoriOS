//
//  HomeViewModel.swift
//  CureitMobile
//
//  Created by mac on 21/03/25.
//

import Foundation

protocol HomeViewModelProtocol: AnyObject {
    func getSettledResponse(response: SettledModel)
}

class HomeViewModel:NSObject, ObservableObject {
    
    weak var view: HomeViewModelProtocol?
    
    init(view: HomeViewModelProtocol) {
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


extension HomeViewModel: HomeVCDelegate {
    func fetchSettledOrders(vendorId: String) {
        self.getSettledOrder(vendorId: vendorId)
    }
}
