//
//  ViewController.swift
//  CureitMobile
//
//  Created by mac on 19/03/25.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textFieldView: UIView!
    @IBOutlet weak var loginBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        self.loginBtn.tintColor = UIColor(hexString: "#13B8A7")
        self.loginBtn.layer.cornerRadius = 14
        self.loginBtn.layer.masksToBounds = true
        self.textField.borderStyle = .none
        self.textField.placeholder = "Mobile Number"
        self.textFieldView.layer.cornerRadius = 14
    }

    @IBAction func loginBtnAction(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "OTPVerifyVC", bundle: nil)
        let nextVC = storyBoard.instantiateViewController(withIdentifier: "OTPVerifyVC")
        nextVC.modalPresentationStyle = .fullScreen
        self.present(nextVC, animated: true)
    }
    
}

