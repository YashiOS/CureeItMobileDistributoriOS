//
//  ChangePassViewModel.swift
//  CureitMobile
//
//  Created by mac on 27/03/25.
//

import Foundation

protocol ChangePassViewModelDelegate: AnyObject {
    func didReceiveChangePassRes(response: ChangePassResponse)
}
class ChangePassViewModel: ObservableObject {
    weak var view: ChangePassViewModelDelegate?
    
    init(view: ChangePassViewModelDelegate) {
        self.view = view
    }
    func changePassword(requestBody: ChangePassRequest) {
        NetworkManager.shared.sendRequest(endpoint: "vendor/changePassword", method: .post,requestBody: requestBody,responseType: ChangePassResponse.self) { result in
            switch result {
            case .success(let success):
                self.view?.didReceiveChangePassRes(response: success)
            case .failure(let failure):
                print("Failure in accept Order is \(failure)")
            }
        }
    }
    
}

struct ChangePassRequest: Encodable {
    let currentPassword: String
    let newPassword: String
    let vendorId: String
}


class ChangePassResponse: Codable {
    let message: String?
}

extension ChangePassViewModel: ChangePassVCDelegate {
    func didSendChangePassRequest(request: ChangePassRequest) {
        self.changePassword(requestBody: request)
    }
}
