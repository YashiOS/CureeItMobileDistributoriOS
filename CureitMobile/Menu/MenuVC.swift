//
//  MenuVC.swift
//  CureitMobile
//
//  Created by mac on 20/03/25.
//

import Foundation
import UIKit

class MenuVC: UIViewController {
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    let menuItems: [(image: UIImage, title: String)] = [
           (UIImage(named: "profile")!, "Profile"),
           (UIImage(named: "changePassword")!, "Change Password"),
           (UIImage(named: "orderHistory")!, "Order History"),
           (UIImage(named: "income")!, "Income"),
           (UIImage(named: "phonecall")!, "Call Customer Care")
       ]
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
    }
    
    func setupUI() {
        self.backBtn.setTitle("", for: .normal)
    }
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "ProfileTableViewCell", bundle: nil), forCellReuseIdentifier: "ProfileTableViewCell")
        self.tableView.separatorStyle = .none
        self.tableView.layer.cornerRadius = 8
    }
    
    @IBAction func backBtnAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
}

extension MenuVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell", for: indexPath) as? ProfileTableViewCell else { return UITableViewCell() }
        cell.configureCell(with: menuItems[indexPath.row].image, title: menuItems[indexPath.row].title)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if menuItems[indexPath.row].title == "Change Password" {
            let storyBoard = UIStoryboard(name: "ChangePassVC", bundle: nil)
            let nextVC = storyBoard.instantiateViewController(withIdentifier: "ChangePassVC")
            nextVC.modalPresentationStyle = .fullScreen
            self.present(nextVC, animated: true)
        } else if menuItems[indexPath.row].title == "Order History" {
            let storyBoard = UIStoryboard(name: "OrderHistoryVC", bundle: nil)
            let nextVC = storyBoard.instantiateViewController(withIdentifier: "OrderHistoryVC")
            nextVC.modalPresentationStyle = .fullScreen
            self.present(nextVC, animated: true)
        } else if menuItems[indexPath.row].title == "Income" {
            let storyboard = UIStoryboard(name: "IncomeVC", bundle: nil)
            let nextVC = storyboard.instantiateViewController(withIdentifier: "IncomeVC")
            nextVC.modalPresentationStyle = .fullScreen
            self.present(nextVC, animated: true)
        } else if menuItems[indexPath.row].title == "Profile" {
            let storyboard = UIStoryboard(name: "ProfileVC", bundle: nil)
            let nextVC = storyboard.instantiateViewController(withIdentifier: "ProfileVC")
            nextVC.modalPresentationStyle = .fullScreen
            self.present(nextVC, animated: true)
        }
        
    }
}
