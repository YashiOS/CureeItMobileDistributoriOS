//
//  HomeVC.swift
//  CureitMobile
//
//  Created by mac on 19/03/25.
//

import UIKit
import Foundation

class HomeVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backbtn: UIButton!
    @IBOutlet weak var backBtnView: UIView!
    var comingFrom: ComingFrom = .incoming
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
    }
    
    func setupUI() {
        backBtnView.layer.cornerRadius = 14
        self.backbtn.setTitle("", for: .normal)
        self.tableView.separatorStyle = .none
    }
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "IncomingOrdersTableViewCell", bundle: nil), forCellReuseIdentifier: "IncomingOrdersTableViewCell")
        self.tableView.register(UINib(nibName: "SettledTableViewCell", bundle: nil), forCellReuseIdentifier: "SettledTableViewCell")
        self.tableView.register(UINib(nibName: "UnsettledTableViewCell", bundle: nil), forCellReuseIdentifier: "UnsettledTableViewCell")
    }
    
    @IBAction func menuBtnAction(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "MenuVC", bundle: nil)
        let nextVC = storyBoard.instantiateViewController(withIdentifier: "MenuVC")
        nextVC.modalPresentationStyle = .fullScreen
        self.present(nextVC, animated: true)
    }
    
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch comingFrom {
        case .incoming:
            return 6
        case .settled:
            return 4
        case .unsettled:
            return 8
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch comingFrom {
        case .incoming:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "IncomingOrdersTableViewCell", for: indexPath) as? IncomingOrdersTableViewCell else { return UITableViewCell() }
            return cell
        case .unsettled:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "UnsettledTableViewCell", for: indexPath) as? UnsettledTableViewCell else { return UITableViewCell() }
            return cell
        case .settled:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SettledTableViewCell", for: indexPath) as? SettledTableViewCell else { return UITableViewCell() }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch comingFrom {
        case .incoming:
            return 66
        case .settled:
            return 74
        case .unsettled:
            return 308
        }
    }
    
}
