//
//  OrderHistoryTableViewCell.swift
//  CureitMobile
//
//  Created by mac on 20/03/25.
//

import UIKit

protocol OrderHistoryCellDelegate: AnyObject {
    func didTapOrderDetails(settledData: SettledDetailModel)
}
class OrderHistoryTableViewCell: UITableViewCell {
    @IBOutlet weak var orderTotalLbl: UILabel!
    @IBOutlet weak var orderIdLbl: UILabel!
    @IBOutlet weak var mainView: UIView!
    var viewModel: SettledViewModel? {
        didSet {
            configureCell()
        }
    }
    
    weak var delegate: OrderHistoryCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    func setupUI() {
        self.mainView.layer.cornerRadius = 4
    }
   
    func configureCell() {
        guard let viewModel = viewModel else { return }
        self.orderIdLbl.text = viewModel.orderId
        self.orderTotalLbl.text = viewModel.totalAmount
    }
    
    @IBAction func orderDetailsbtnAction(_ sender: Any) {
        guard let viewModel = viewModel else { return }
        self.delegate?.didTapOrderDetails(settledData: viewModel.settledData)
    }
    
}
