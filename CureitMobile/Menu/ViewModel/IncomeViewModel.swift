//
//  IncomeViewModel.swift
//  CureitMobile
//
//  Created by Gagan Pareek on 22/03/25.
//

import Foundation

protocol IncomeViewModelProtocol: AnyObject {
    func getIncomeDetails(response: IncomeDetails)
}

class IncomeViewModel:NSObject, ObservableObject {
    
    weak var view: IncomeViewModelProtocol?
    
    init(view: IncomeViewModelProtocol) {
        self.view = view
    }
    
    func getIncomeDetails(vendorId: String) {
        let parameters: [String: Any] = ["vendorId": vendorId]
        NetworkManager.shared.getWithQueryParameters(endpoint: "vendor/incomeDetails",parameters: parameters, responseType: IncomeDetails.self) { result in
            switch result {
            case .success(let success):
                print("Fetched Income Details are \(success.data)")
                self.view?.getIncomeDetails(response: success)
            case .failure(let failure):
                print("Failure is \(failure)")
            }
        }
    }
}


extension IncomeViewModel: IncomeVCDelegate {
    func fetchIncomeDetails(vendorId: String) {
        self.getIncomeDetails(vendorId: vendorId)
    }
}
