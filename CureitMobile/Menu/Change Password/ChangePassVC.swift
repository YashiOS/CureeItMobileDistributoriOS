//
//  ChangePassVC.swift
//  CureitMobile
//
//  Created by mac on 20/03/25.
//

import Foundation
import UIKit


protocol ChangePassVCDelegate: AnyObject {
    func didSendChangePassRequest(request: ChangePassRequest)
}
class ChangePassVC: UIViewController {
    @IBOutlet weak var retypeNewPassTF: UITextField!
    @IBOutlet weak var newPassTF: UITextField!
    @IBOutlet weak var currentTF: UITextField!
    @IBOutlet weak var retypeNewpasswordTFView: UIView!
    @IBOutlet weak var newPasswordTFView: UIView!
    @IBOutlet weak var confirmBt: UIButton!
    @IBOutlet weak var currentPasswordTFView: UIView!
    
    
    var viewModel: ChangePassVCDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupViewModel()
    }
    
    func setupViewModel() {
        if viewModel == nil {
            self.viewModel = ChangePassViewModel(view: self)
        }
    }
    func setupUI() {
        currentPasswordTFView.layer.cornerRadius = 14
        newPasswordTFView.layer.cornerRadius = 14
        retypeNewpasswordTFView.layer.cornerRadius = 14
        currentTF.borderStyle = .none
        newPassTF.borderStyle = .none
        retypeNewPassTF.borderStyle = .none
        self.confirmBt.tintColor = UIColor(hexString: "#0A9682")
        self.confirmBt.layer.cornerRadius = 16
        self.confirmBt.layer.masksToBounds = true
    }
    @IBAction func backBtnAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
    @IBAction func confirmBtnAction(_ sender: Any) {
        guard let currentPassword = currentTF.text, !currentPassword.isEmpty else {
               print("Current password is required")
               return
           }
           
           guard let newPassword = newPassTF.text, !newPassword.isEmpty else {
               print("New password is required")
               return
           }
           
           guard let retypeNewPassword = retypeNewPassTF.text, newPassword == retypeNewPassword else {
               print("New password and Retyped password do not match")
               return
           }
           
        let request = ChangePassRequest(currentPassword: currentPassword, newPassword: newPassword, vendorId: "SUN-144")
           viewModel?.didSendChangePassRequest(request: request)
    }
}
extension ChangePassVC: ChangePassViewModelDelegate {
    func didReceiveChangePassRes(response: ChangePassResponse) {
        print("Response for change pass is \(response)")
    }
}
