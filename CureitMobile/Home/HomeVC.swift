//
//  HomeVC.swift
//  CureitMobile
//
//  Created by mac on 19/03/25.
//

import UIKit
import Foundation
import SVProgressHUD

protocol HomeVCDelegate: AnyObject {
    func fetchSettledOrders(vendorId: String)
    func fetchUnsettledOrders(vendorId: String)
    func fetchIncomingOrders()
    func sendAcceptOrderRequest(request: AcceptOrderRequest)
}
class HomeVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backbtn: UIButton!
    @IBOutlet weak var backBtnView: UIView!
    var comingFrom: ComingFrom = .incoming
    var viewModel: HomeVCDelegate?
    var settledOrders: [SettledDetailModel]?
    var unsettledOrders: [UnsettledDetailModel]?
    var incomingOrders: [IncomingOrder]?
    var isPlusTapped: Bool = false
    var expandedIndexPaths: Set<IndexPath> = []
    var apiTimer: Timer?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupViewModel()
        setupTableView()
        SVProgressHUD.show(withStatus: "Loading....")
        self.viewModel?.fetchSettledOrders(vendorId: "SUN-144")
        self.viewModel?.fetchUnsettledOrders(vendorId: "SUN-144")
        self.viewModel?.fetchIncomingOrders()
        startAPITimer()
    }
    
    func setupUI() {
        backBtnView.layer.cornerRadius = 14
        self.backbtn.setTitle("", for: .normal)
        self.tableView.separatorStyle = .none
    }
    
    func startAPITimer() {
        apiTimer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(callAPIs), userInfo: nil, repeats: true)
    }
    
    @objc func callAPIs() {
        self.viewModel?.fetchSettledOrders(vendorId: "SUN-144")
        self.viewModel?.fetchUnsettledOrders(vendorId: "SUN-144")
        self.viewModel?.fetchIncomingOrders()
    }
    func setupViewModel() {
        if viewModel == nil {
            self.viewModel = HomeViewModel(view: self)
        }
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
            return incomingOrders?.count ?? 0
        case .settled:
            return settledOrders?.count ?? 0
        case .unsettled:
            return unsettledOrders?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch comingFrom {
        case .incoming:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "IncomingOrdersTableViewCell", for: indexPath) as? IncomingOrdersTableViewCell else { return UITableViewCell() }
            
            if let incomingOrders = incomingOrders {
                let incomingOrder = incomingOrders[indexPath.row]
                let viewModel = IncomingViewModel(incomingData: incomingOrder)
                cell.delegate = self
                cell.viewModel = viewModel
                let isExpanded = expandedIndexPaths.contains(indexPath)
                cell.setExpanded(isExpanded)
            }
            return cell
        case .unsettled:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "UnsettledTableViewCell", for: indexPath) as? UnsettledTableViewCell else { return UITableViewCell() }
            if let unsettledOrders = unsettledOrders?[indexPath.row] {
                let viewModel = UnSettledViewModel(unsettledData: unsettledOrders)
                cell.viewModel = viewModel
            }
            return cell
        case .settled:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SettledTableViewCell", for: indexPath) as? SettledTableViewCell else { return UITableViewCell() }
            if let settledOrders = settledOrders {
                let settledOrder = settledOrders[indexPath.row]
                let viewModel = SettledViewModel(settledData: settledOrder)
                cell.viewModel = viewModel
                cell.delegate = self
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch comingFrom {
        case .incoming:
            return expandedIndexPaths.contains(indexPath) ? UITableView.automaticDimension : 60
        case .settled:
            return 74
        case .unsettled:
            return UITableView.automaticDimension
        }
    }
    
}

extension HomeVC: HomeViewModelProtocol {
    func getSettledResponse(response: SettledModel) {
        self.settledOrders = response.data
        SVProgressHUD.dismiss()
        self.tableView.reloadData()
    }
    
    func getUnsettledResponse(response: UnsettledModel) {
        self.unsettledOrders = response.data
        SVProgressHUD.dismiss()
        self.tableView.reloadData()
    }
    
    func getIncomingResponse(response: IncomingOrdersResponse) {
        self.incomingOrders = response.data
        SVProgressHUD.dismiss()
        self.tableView.reloadData()
    }
    
    func getAcceptedOrderResponse(response: AcceptOrderResponse) {
        if response.success {
            SVProgressHUD.dismiss()
            self.viewModel?.fetchIncomingOrders()
            self.tableView.reloadData()
        }
    }
}

extension HomeVC: IncomingOrdersTableViewCellDelegate {
    func didTapAcceptOrder(in cell: IncomingOrdersTableViewCell, orderId: String, vendorId: String, acceptedItems: [String], rejectedItems: [String]) {
        SVProgressHUD.show(withStatus: "Accepting.....")
        let request = AcceptOrderRequest(orderId: orderId, vendorId: vendorId, acceptedItems: acceptedItems, rejectedItems: rejectedItems)
        self.viewModel?.sendAcceptOrderRequest(request: request)
    }
    
    func didTapAcceptOrder(in cell: IncomingOrdersTableViewCell) {
      
    }
    
    
    func didTapPlusButton(in cell: IncomingOrdersTableViewCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            if expandedIndexPaths.contains(indexPath) {
                expandedIndexPaths.remove(indexPath)
            } else {
                expandedIndexPaths.insert(indexPath)
            }
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
    
}

extension HomeVC: SettledTableViewDelegate {
    func presentOrderDetailsVC(settledData: SettledDetailModel) {
        let storyBoard = UIStoryboard(name: "OrderDetailsVC", bundle: nil)
        let nextVC = storyBoard.instantiateViewController(withIdentifier: "OrderDetailsVC") as? OrderDetailsVC
        nextVC?.settledOrders = settledData
        nextVC?.modalPresentationStyle = .fullScreen
        self.present(nextVC!, animated: true)
    }
}
