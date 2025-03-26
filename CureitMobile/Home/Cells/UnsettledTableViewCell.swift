//
//  UnsettledTableViewCell.swift
//  CureitMobile
//
//  Created by mac on 20/03/25.
//

import UIKit

class UnsettledTableViewCell: UITableViewCell {

    @IBOutlet weak var mainViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var totalAmountOrderLbl: UILabel!
    @IBOutlet weak var orderIdLbl: UILabel!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: UnSettledViewModel? {
        didSet {
            configureCell()
            self.updateBottomViewHeight()
            self.tableView.reloadData()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        setupTableView()
     
    }
    func setupUI() {
        self.mainView.layer.cornerRadius = 4
    }
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "UnsettledDetailedTableViewCell", bundle: nil), forCellReuseIdentifier: "UnsettledDetailedTableViewCell")
        self.tableView.separatorStyle = .none
    }
    
    func configureCell() {
        guard let viewModel = viewModel else { return }
        self.orderIdLbl.text = viewModel.orderId
        self.totalAmountOrderLbl.text = viewModel.totalAmount
    }
    
    func updateBottomViewHeight() {
        let rowCount = self.viewModel?.unsettledData.products?.count ?? 0
        let rowHeight: CGFloat = 76
        let totalHeight = CGFloat(rowCount) * rowHeight
        let newHeight = max(totalHeight, 76)
        DispatchQueue.main.async {
            self.contentView.heightAnchor.constraint(equalToConstant: newHeight).isActive = true
                   self.layoutIfNeeded()
            
            
        }
    }
    
    
}

extension UnsettledTableViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.unsettledData.products?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let products = self.viewModel?.unsettledData.products, indexPath.row < products.count else {
              return UITableViewCell()
          }
          
          guard let cell = tableView.dequeueReusableCell(withIdentifier: "UnsettledDetailedTableViewCell", for: indexPath) as? UnsettledDetailedTableViewCell else {
              return UITableViewCell()
          }
        let viewModel = UnSettledDetailsViewModel(unSettledProducts: products[indexPath.row])
        cell.viewModel = viewModel
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 76
    }
    
}
