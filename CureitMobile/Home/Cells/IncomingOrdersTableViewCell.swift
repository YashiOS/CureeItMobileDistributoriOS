//
//  IncomingOrdersTableViewCell.swift
//  CureitMobile
//
//  Created by mac on 20/03/25.
//

import UIKit

protocol IncomingOrdersTableViewCellDelegate: AnyObject {
    func didTapPlusButton(in cell: IncomingOrdersTableViewCell)
    func didTapAcceptOrder(in cell: IncomingOrdersTableViewCell, orderId: String, vendorId: String,acceptedItems: [String], rejectedItems: [String])
}

class IncomingOrdersTableViewCell: UITableViewCell {

    @IBOutlet weak var rejectBtn: UIButton!
    @IBOutlet weak var acceptBtn: UIButton!
    @IBOutlet weak var bottomViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var plusBtn: UIButton!
    @IBOutlet weak var plusBtnView: UIView!
    @IBOutlet weak var orderNumberLbl: UILabel!
    @IBOutlet weak var bottomView: UIView!
    weak var delegate: IncomingOrdersTableViewCellDelegate?

    var viewModel: IncomingViewModel? {
        didSet {
            configureCell()
        }
    }
    
    var selectedProducts: [String: Bool] = [:]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func setupUI() {
        self.plusBtnView.layer.cornerRadius = 4
        self.plusBtn.setTitle("", for: .normal)
        self.mainView.layer.cornerRadius = 4
        self.bottomView.layer.cornerRadius = 4
        self.bottomView.isHidden = true
        self.rejectBtn.layer.borderWidth = 1
        self.rejectBtn.layer.borderColor = UIColor(hexString: "#B6C2E2").cgColor
        self.acceptBtn.backgroundColor = .clear
        self.acceptBtn.tintColor = UIColor(hexString: "#13B8A7")
        self.rejectBtn.backgroundColor = .clear
        self.rejectBtn.tintColor = UIColor.clear
        self.rejectBtn.layer.cornerRadius = 8
        self.acceptBtn.layer.cornerRadius = 8
    }
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "IncomingOrderSelectionTableViewCell", bundle: nil), forCellReuseIdentifier: "IncomingOrderSelectionTableViewCell")
        self.tableView.separatorStyle = .none
    }
    func configureCell() {
        guard let viewModel = viewModel else { return }
        self.orderNumberLbl.text = viewModel.orderId
        self.setupTableView()
        bottomView.isHidden = true
    }

    func updateBottomViewHeight() {
        let rowCount = self.viewModel?.incomingData.orderItems.count ?? 0
        let rowHeight: CGFloat = 74
        let totalHeight = CGFloat(rowCount) * rowHeight
        let newHeight = max(totalHeight, 74) + 100
        self.bottomViewHeightConstraint.constant = newHeight
        self.layoutIfNeeded()
    }
    func setExpanded(_ expanded: Bool) {
        bottomView.isHidden = !expanded
        if expanded {
            updateBottomViewHeight()
            tableView.reloadData()
        }
    }
    
    @IBAction func plusBtnAction(_ sender: Any) {
        self.delegate?.didTapPlusButton(in: self)
    }
    
    @IBAction func acceptBtnTapped(_ sender: Any) {
        let selectedItems = getAcceptedRejectedProducts()
        self.delegate?.didTapAcceptOrder(in: self, orderId: viewModel?.orderID ?? "", vendorId: "SUN-144", acceptedItems: selectedItems["accepted"] ?? [], rejectedItems: selectedItems["rejected"] ?? [])
        self.selectedProducts.removeAll(keepingCapacity: false)
        setExpanded(false)
        
    }
    @IBAction func rejectBtnTapped(_ sender: Any) {
        
    }
    
}

extension IncomingOrdersTableViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = self.viewModel?.incomingData.orderItems.count ?? 0
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "IncomingOrderSelectionTableViewCell", for: indexPath) as? IncomingOrderSelectionTableViewCell else { return UITableViewCell() }
        guard let viewModel = self.viewModel,
                 indexPath.row < viewModel.incomingData.orderItems.count else {
               return cell
           }
        cell.delegate = self
        let orderedItem = self.viewModel?.incomingData.orderItems[indexPath.row]
        let itemViewModel = IncomingOrdersDetailsViewModel(orderedItem: orderedItem!)
        cell.viewModel = itemViewModel
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 74
    }
    
}

extension IncomingOrdersTableViewCell: IncomingOrderSelectionTableViewCellDelegate {
    func didToggleSelection(for productId: String, isSelected: Bool) {
        selectedProducts[productId] = isSelected
    }
    
    func getAcceptedRejectedProducts() -> [String: [String]] {
        let allProducts = viewModel?.incomingData.orderItems.map { $0.productId } ?? []
        let accepted = allProducts.filter { selectedProducts[$0] == true }
        let rejected = allProducts.filter { selectedProducts[$0] != true }
        
        return ["accepted": accepted, "rejected": rejected]
    }
    
}
