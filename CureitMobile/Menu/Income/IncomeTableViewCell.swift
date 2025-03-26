//
//  IncomeTableViewCell.swift
//  CureitMobile
//
//  Created by mac on 20/03/25.
//

import UIKit

class IncomeTableViewCell: UITableViewCell {
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var orderTotalLbl: UILabel!
    @IBOutlet weak var orderIDLbl: UILabel!
    
    var viewModel: IncomeDetailsViewModel? {
        didSet {
            configureCell()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func setupUI() {
        self.mainView.layer.cornerRadius = 4
    }
    
    func configureCell() {
        guard let viewModel = viewModel else { return }
        self.orderIDLbl.text = viewModel.orderId
        self.orderTotalLbl.text = viewModel.totalAmount
    }
    
}
