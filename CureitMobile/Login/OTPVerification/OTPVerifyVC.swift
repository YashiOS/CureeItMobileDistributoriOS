//
//  OTPVerifyVC.swift
//  CureitMobile
//
//  Created by mac on 19/03/25.
//

import UIKit
import Foundation

class OTPVerifyVC: UIViewController {
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var confirmOtpBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        confirmOtpBtn.layer.cornerRadius = 14
        confirmOtpBtn.tintColor = UIColor(hexString: "#13B8A7")
    }
    
    
    @IBAction func backBtnAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    @IBAction func confirmBtnAction(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "TabBar", bundle: nil)
        if let tabBarVC = storyBoard.instantiateViewController(withIdentifier: "TabBar") as? UITabBarController {
            tabBarVC.modalPresentationStyle = .fullScreen
            present(tabBarVC, animated: true, completion: nil)
        }
    }
}
