//
//  OrderDeliveredTableViewCell.swift
//  CureitMobile
//
//  Created by mac on 24/03/25.
//

import UIKit

class OrderDeliveredTableViewCell: UITableViewCell {

    @IBOutlet weak var orderCreatedLbl: UILabel!
    @IBOutlet weak var orderIdLbl: UILabel!
    var viewModel: SettledViewModel? {
        didSet {
            configureCell()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell() {
        guard let viewModel = viewModel else { return }
        self.orderIdLbl.text = viewModel.orderId
        let deliveredAt = formatDateString(viewModel.deliveredAt)
        self.orderCreatedLbl.text = ("Delivered on:\(deliveredAt ?? "null")")
    }
    
}
