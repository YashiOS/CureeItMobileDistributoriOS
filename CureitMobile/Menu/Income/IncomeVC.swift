//
//  IncomeVC.swift
//  CureitMobile
//
//  Created by mac on 20/03/25.
//

import Foundation
import UIKit

class IncomeVC: UIViewController {
    @IBOutlet weak var startDateView: UIView!
    @IBOutlet weak var endDateBtn: UIButton!
    @IBOutlet weak var startDateBtn: UIButton!
    @IBOutlet weak var endDateView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDateButtons()
        setupTableView()
    }
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "IncomeTableViewCell", bundle: nil), forCellReuseIdentifier: "IncomeTableViewCell")
        self.tableView.separatorStyle = .none
    }
    
    func setupDateButtons() {
        let buttonFont = UIFont.systemFont(ofSize: 14, weight: .medium)
        let titleColor = UIColor(hexString: "#696F8C")
        
        let initialDateFormat = "MM.DD.YYYY"
        startDateBtn.setTitle(initialDateFormat, for: .normal)
        endDateBtn.setTitle(initialDateFormat, for: .normal)
        
        startDateBtn.titleLabel?.font = buttonFont
        endDateBtn.titleLabel?.font = buttonFont
        
        startDateBtn.setTitleColor(titleColor, for: .normal)
        endDateBtn.setTitleColor(titleColor, for: .normal)
        self.startDateView.layer.cornerRadius = 4
        self.startDateView.layer.masksToBounds = true
        self.endDateView.layer.cornerRadius = 4
        self.endDateView.layer.masksToBounds = true
    }
    
    
    @IBAction func backBtnAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}

extension IncomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "IncomeTableViewCell", for: indexPath) as? IncomeTableViewCell else { return UITableViewCell() }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}

