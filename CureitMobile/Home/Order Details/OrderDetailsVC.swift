//
//  OrderDetailsVC.swift
//  CureitMobile
//
//  Created by mac on 24/03/25.
//

import UIKit
import Foundation
class OrderDetailsVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var settledOrders: SettledDetailModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "OrderDeliveredTableViewCell", bundle: nil), forCellReuseIdentifier: "OrderDeliveredTableViewCell")
        self.tableView.register(UINib(nibName: "OrderListTableViewCell", bundle: nil), forCellReuseIdentifier: "OrderListTableViewCell")
        self.tableView.register(UINib(nibName: "OrderPricingDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "OrderPricingDetailsTableViewCell")
        self.tableView.register(UINib(nibName: "HeaderOrderTableViewCell", bundle: nil), forCellReuseIdentifier: "HeaderOrderTableViewCell")
        self.tableView.separatorStyle = .none
        
    }
    
    @IBAction func backBtnAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
}

extension OrderDetailsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
               case 0:
                   guard let cell = tableView.dequeueReusableCell(withIdentifier: "OrderDeliveredTableViewCell") as? OrderDeliveredTableViewCell else { return UITableViewCell() }
                   if let settledOrders = settledOrders {
                       let viewModel = SettledViewModel(settledData: settledOrders)
                       cell.viewModel = viewModel
                   }
                   return cell
               
               case 1:
                   guard let headerCell = tableView.dequeueReusableCell(withIdentifier: "HeaderOrderTableViewCell") as? HeaderOrderTableViewCell else { return UITableViewCell() }
                   headerCell.headerLabel.text = "Items Ordered"
                   return headerCell
               
               case 2:
                   guard let cell = tableView.dequeueReusableCell(withIdentifier: "OrderListTableViewCell", for: indexPath) as? OrderListTableViewCell else { return UITableViewCell() }
                   if let settledProducts = settledOrders {
                       cell.settledProducts = settledProducts
                   }
                   return cell
               
               case 3:
                   guard let headerCell = tableView.dequeueReusableCell(withIdentifier: "HeaderOrderTableViewCell") as? HeaderOrderTableViewCell else { return UITableViewCell() }
                   headerCell.headerLabel.text = "Bill Summary"
                   return headerCell
               
               case 4:
                   guard let cell = tableView.dequeueReusableCell(withIdentifier: "OrderPricingDetailsTableViewCell", for: indexPath) as? OrderPricingDetailsTableViewCell else { return UITableViewCell() }
                   if let settledOrders = settledOrders {
                       let viewModel = SettledViewModel(settledData: settledOrders)
                       cell.viewModel = viewModel
                   }
                   return cell
               
               default:
                   return UITableViewCell()
               }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
               case 0:
                   return 121
               case 1, 3:
                   return 34
               case 2:
                   return UITableView.automaticDimension
               case 4:
                   return 150
               default:
                   return 0
               }
    }
}
