//
//  ChangePassVC.swift
//  CureitMobile
//
//  Created by mac on 20/03/25.
//

import Foundation
import UIKit

class ChangePassVC: UIViewController {
    @IBOutlet weak var retypeNewPassTF: UITextField!
    @IBOutlet weak var newPassTF: UITextField!
    @IBOutlet weak var currentTF: UITextField!
    @IBOutlet weak var retypeNewpasswordTFView: UIView!
    @IBOutlet weak var newPasswordTFView: UIView!
    @IBOutlet weak var currentPasswordTFView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        currentPasswordTFView.layer.cornerRadius = 14
        newPasswordTFView.layer.cornerRadius = 14
        retypeNewpasswordTFView.layer.cornerRadius = 14
        currentTF.borderStyle = .none
        newPassTF.borderStyle = .none
        retypeNewPassTF.borderStyle = .none
    }
    @IBAction func backBtnAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}
