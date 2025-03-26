//
//  HomeViewModel.swift
//  CureitMobile
//
//  Created by mac on 21/03/25.
//

import Foundation

protocol HomeViewModelProtocol: AnyObject {
    func getSettledResponse(response: SettledModel)
    func getUnsettledResponse(response: UnsettledModel)
    func getIncomingResponse(response: IncomingOrdersResponse)
    func getAcceptedOrderResponse(response: AcceptOrderResponse)
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
    
    func getUnsettledOrder(vendorId: String) {
        let parameters: [String: Any] = ["vendorId": vendorId]
        NetworkManager.shared.getWithQueryParameters(endpoint: "vendor/vendorUnsettledOrders",parameters: parameters, responseType: UnsettledModel.self) { result in
            switch result {
            case .success(let success):
                self.view?.getUnsettledResponse(response: success)
            case .failure(let failure):
                print("Failure is \(failure)")
            }
        }
    }
    
    func getIncomingOrders() {
        NetworkManager.shared.sendRequest(endpoint: "vendor/vendorIncomingOrders", responseType: IncomingOrdersResponse.self) { result in
            switch result {
            case .success(let success):
                self.view?.getIncomingResponse(response: success)
            case .failure(let failure):
                print("Failure in incoming is \(failure)")
            }
        }
    }
    
    func acceptIncomingOrder(requestBody: AcceptOrderRequest) {
        NetworkManager.shared.sendRequest(endpoint: "order/acceptOrder", method: .post,requestBody: requestBody,responseType: AcceptOrderResponse.self) { result in
            switch result {
            case .success(let success):
                self.view?.getAcceptedOrderResponse(response: success)
            case .failure(let failure):
                print("Failure in accept Order is \(failure)")
            }
        }
    }
}


extension HomeViewModel: HomeVCDelegate {
    func fetchSettledOrders(vendorId: String) {
        self.getSettledOrder(vendorId: vendorId)
    }
    
    func fetchUnsettledOrders(vendorId: String) {
        self.getUnsettledOrder(vendorId: vendorId)
    }
    
    func fetchIncomingOrders() {
        self.getIncomingOrders()
    }
    
    func sendAcceptOrderRequest(request: AcceptOrderRequest) {
        self.acceptIncomingOrder(requestBody: request)
    }
}
