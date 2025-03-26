//
//  OrderPricingDetailsTableViewCell.swift
//  CureitMobile
//
//  Created by mac on 24/03/25.
//

import UIKit

class OrderPricingDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var totalDiscountLbl: UILabel!
    @IBOutlet weak var taxAndServicesLbl: UILabel!
    @IBOutlet weak var totalAmountLbl: UILabel!
    
    var viewModel: SettledViewModel? {
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
        self.totalAmountLbl.text = viewModel.orderAmount
        self.totalDiscountLbl.text = viewModel.discountPrice
        self.taxAndServicesLbl.text = viewModel.taxAndServices
    }
    
}
