//
//  OrderListTableViewCell.swift
//  CureitMobile
//
//  Created by mac on 24/03/25.
//

import UIKit

class OrderListTableViewCell: UITableViewCell {

    @IBOutlet weak var tableView: UITableView!
    var settledProducts: SettledDetailModel? {
        didSet {
            self.updateBottomViewHeight()
            self.tableView.reloadData()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        setupTableView()
    }
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "OrderListDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "OrderListDetailsTableViewCell")
        self.tableView.separatorStyle = .none
    }
    
    func updateBottomViewHeight() {
        let rowCount = self.settledProducts?.products?.count ?? 0
        let rowHeight: CGFloat = 80
        let totalHeight = CGFloat(rowCount) * rowHeight
        let newHeight = max(totalHeight, 80)
        self.contentView.heightAnchor.constraint(equalToConstant: newHeight).isActive = true
        DispatchQueue.main.async {
            self.layoutIfNeeded()
        }
    }
    
}

extension OrderListTableViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.settledProducts?.products?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "OrderListDetailsTableViewCell", for: indexPath) as? OrderListDetailsTableViewCell else { return UITableViewCell() }
        if let settledProducts = self.settledProducts {
            if let products = settledProducts.products?[indexPath.row] {
                let viewModel = OrderListDetailsViewModel(settledProducts: products)   
                cell.viewModel = viewModel
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
