//
//  CustomerCareVc.swift
//  CureitMobile
//
//  Created by mac on 27/03/25.
//

import UIKit
import Foundation
import SVProgressHUD
class CustomerCareVc: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    let supportOptions: [(title: String, value: String)] = [
           ("Need Call Support?", "Call +918890170172"),
           ("Need Email Support?", "support@cureeit.com")
       ]
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        SVProgressHUD.dismiss()
    }
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "CustomerCareTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomerCareTableViewCell")
        self.tableView.register(UINib(nibName: "HeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "HeaderTableViewCell")
        self.tableView.separatorStyle = .none
    }
    @IBAction func backBtnAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    @objc func callNumber() {
            if let phoneURL = URL(string: "tel://+918890170172"), UIApplication.shared.canOpenURL(phoneURL) {
                UIApplication.shared.open(phoneURL)
            }
        }
    @objc func sendEmail() {
           if let emailURL = URL(string: "mailto:support@cureeit.com"), UIApplication.shared.canOpenURL(emailURL) {
               UIApplication.shared.open(emailURL)
           }
       }
}

extension CustomerCareVc: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return supportOptions.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomerCareTableViewCell", for: indexPath) as? CustomerCareTableViewCell else { return UITableViewCell() }
        let supportDetail = supportOptions[indexPath.section].value
        cell.customerCareLbl.text = supportDetail
        if supportDetail.contains("Call") {
                    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(callNumber))
                    cell.customerCareLbl?.isUserInteractionEnabled = true
                    cell.customerCareLbl?.addGestureRecognizer(tapGesture)
                } else if supportDetail.contains("support@cureeit.com") {
                    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(sendEmail))
                    cell.customerCareLbl?.isUserInteractionEnabled = true
                    cell.customerCareLbl?.addGestureRecognizer(tapGesture)
                }
        
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
           guard let headerCell = tableView.dequeueReusableCell(withIdentifier: "HeaderTableViewCell") as? HeaderTableViewCell else {
               return nil
           }
           headerCell.viewModel = HeaderModel(titleString: supportOptions[section].title)
           return headerCell.contentView
       }
       
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
       func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
           return 25
       }
    
}
