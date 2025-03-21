//
//  OTPVerifyVC.swift
//  CureitMobile
//
//  Created by mac on 19/03/25.
//

import UIKit
import Foundation

class OTPVerifyVC: UIViewController {
    @IBOutlet weak var otp5TF: UITextField!
    @IBOutlet weak var otp6TF: UITextField!
    @IBOutlet weak var otp4TF: UITextField!
    @IBOutlet weak var otp1TF: UITextField!
    @IBOutlet weak var otp3TF: UITextField!
    @IBOutlet weak var otp2TF: UITextField!
    @IBOutlet weak var otp6View: UIView!
    @IBOutlet weak var otp4View: UIView!
    @IBOutlet weak var otp5View: UIView!
    @IBOutlet weak var otp2View: UIView!
    @IBOutlet weak var otp3View: UIView!
    @IBOutlet weak var otp1View: UIView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var timerLbl: UILabel!
    @IBOutlet weak var confirmOtpBtn: UIButton!
    var countdownTimer: Timer?
       var remainingTime = 120
       var isTimerFinished = false
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        startTimer()
        setupOTPTextFields()
    }
    
    func setupUI() {
        let otpViews = [otp1View, otp2View, otp3View, otp4View, otp5View, otp6View]
        
        for otpView in otpViews {
            otpView?.layer.cornerRadius = 14
            otpView?.layer.masksToBounds = true
            otpView?.layer.borderWidth = 1
            otpView?.layer.borderColor = UIColor(hexString: "#E9F3FB").cgColor
            
        }
        
        confirmOtpBtn.layer.cornerRadius = 16
        confirmOtpBtn.layer.masksToBounds = true
        confirmOtpBtn.tintColor = UIColor(hexString: "#13B8A7").withAlphaComponent(0.3)
        confirmOtpBtn.isUserInteractionEnabled = false

        let otpTextFields = [otp1TF, otp2TF, otp3TF, otp4TF, otp5TF, otp6TF]
        for otpTextField in otpTextFields {
            otpTextField?.borderStyle = .none
            
        }
    }
    
    func checkOTPCompletion() {
        let otpTextFields = [otp1TF, otp2TF, otp3TF, otp4TF, otp5TF, otp6TF]
        let allFilled = otpTextFields.allSatisfy { $0?.text?.count == 1 }
        
        if allFilled {
            confirmOtpBtn.tintColor = UIColor(hexString: "#13B8A7")
            confirmOtpBtn.isUserInteractionEnabled = true
        } else {
            confirmOtpBtn.tintColor = UIColor(hexString: "#13B8A7").withAlphaComponent(0.3)
            confirmOtpBtn.isUserInteractionEnabled = false
        }
    }
    
    func setupOTPTextFields() {
           let otpTextFields = [otp1TF, otp2TF, otp3TF, otp4TF, otp5TF, otp6TF]
           
           for textField in otpTextFields {
               textField?.delegate = self
               textField?.keyboardType = .numberPad
               textField?.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
               textField?.textColor = UIColor(hexString: "#37B890")
               textField?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
           }
       }
    
    
    func startTimer() {
         isTimerFinished = false
        timerLbl.text = Time.shared.formatTime(seconds: remainingTime)
         
         countdownTimer = Timer.scheduledTimer(timeInterval: 1.0,
                                               target: self,
                                               selector: #selector(updateTimer),
                                               userInfo: nil,
                                               repeats: true)
     }

    
    @objc func updateTimer() {
           if remainingTime > 0 {
               remainingTime -= 1
               timerLbl.text = Time.shared.formatTime(seconds: remainingTime)
           } else {
               countdownTimer?.invalidate()
               countdownTimer = nil
               isTimerFinished = true
               timerLbl.text = "Time's up!"
           }
       }
    
    
    @IBAction func backBtnAction(_ sender: Any) {
        countdownTimer?.invalidate()
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

extension OTPVerifyVC: UITextFieldDelegate {
    @objc func textFieldDidChange(_ textField: UITextField) {
           if let text = textField.text, text.count == 1 {
               switch textField {
               case otp1TF: otp2TF.becomeFirstResponder()
               case otp2TF: otp3TF.becomeFirstResponder()
               case otp3TF: otp4TF.becomeFirstResponder()
               case otp4TF: otp5TF.becomeFirstResponder()
               case otp5TF: otp6TF.becomeFirstResponder()
               case otp6TF: otp6TF.resignFirstResponder()
               default: break
               }
           }
        checkOTPCompletion()
       }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
           if string.rangeOfCharacter(from: CharacterSet.decimalDigits) != nil {
               return textField.text?.count == 0
           }
           if string.isEmpty {
               switch textField {
               case otp6TF: otp5TF.becomeFirstResponder()
               case otp5TF: otp4TF.becomeFirstResponder()
               case otp4TF: otp3TF.becomeFirstResponder()
               case otp3TF: otp2TF.becomeFirstResponder()
               case otp2TF: otp1TF.becomeFirstResponder()
               case otp1TF: otp1TF.resignFirstResponder()
               default: break
               }
               return true
           }
           
           return false
       }
}
