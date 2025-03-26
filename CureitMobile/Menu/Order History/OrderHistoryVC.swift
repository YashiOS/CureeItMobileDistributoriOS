//
//  OrderHistoryVC.swift
//  CureitMobile
//
//  Created by mac on 20/03/25.
//

import UIKit
import Foundation
import SVProgressHUD

protocol OrderHistoryVCDelegate: AnyObject {
    func fetchSettledOrders(vendorId: String)
}

class OrderHistoryVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backBtn: UIButton!
    
    var viewModel: OrderHistoryVCDelegate?
    var settledOrders: [SettledDetailModel]?
    var groupedSettledOrders: [(date: String, items: [SettledDetailModel])] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.show(withStatus: "Loading...")
        setupViewModel()
        self.viewModel?.fetchSettledOrders(vendorId: "SUN-144")
        setupTableView()
    }
    
    func setupViewModel() {
        if viewModel == nil {
            self.viewModel = OrderHistoryViewModel(view: self)
        }
    }
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        self.tableView.register(UINib(nibName: "OrderHistoryTableViewCell", bundle: nil), forCellReuseIdentifier: "OrderHistoryTableViewCell")
        self.tableView.register(UINib(nibName: "HeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "HeaderTableViewCell")
    }
    @IBAction func backBtnAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    func organizeSettledOrdersByDate() {
        guard let orders = settledOrders else { return }
        
        let groupedDictionary = Dictionary(grouping: orders) { order -> String in
            return formatDateString(order.deliveredAt ?? "")!
        }
        
        groupedSettledOrders = groupedDictionary.sorted { $0.key > $1.key }
            .map { (date: $0.key, items: $0.value) }
    }
    
}

extension OrderHistoryVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return groupedSettledOrders.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupedSettledOrders[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "OrderHistoryTableViewCell", for: indexPath) as? OrderHistoryTableViewCell else {
              return UITableViewCell()
          }
          
          let order = groupedSettledOrders[indexPath.section].items[indexPath.row]
          let viewModel = SettledViewModel(settledData: order)
          cell.viewModel = viewModel
          cell.delegate = self
          
          return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerCell = tableView.dequeueReusableCell(withIdentifier: "HeaderTableViewCell") as? HeaderTableViewCell else {
            return nil
        }

        let sectionDate = groupedSettledOrders[section].date
        let headerModel = HeaderModel(titleString: sectionDate)
        headerCell.viewModel = headerModel

        return headerCell.contentView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 34
    }
}

extension OrderHistoryVC: OrderHistoryViewModelDelegate {
    func getSettledResponse(response: SettledModel) {
        self.settledOrders = response.data
        self.organizeSettledOrdersByDate()
        SVProgressHUD.dismiss()
        self.tableView.reloadData()
    }
}

extension OrderHistoryVC: OrderHistoryCellDelegate {
    func didTapOrderDetails(settledData: SettledDetailModel) {
        let storyBoard = UIStoryboard(name: "OrderDetailsVC", bundle: nil)
        let nextVC = storyBoard.instantiateViewController(withIdentifier: "OrderDetailsVC") as? OrderDetailsVC
        nextVC?.settledOrders = settledData
        nextVC?.modalPresentationStyle = .fullScreen
        self.present(nextVC!, animated: true)
    }

}
