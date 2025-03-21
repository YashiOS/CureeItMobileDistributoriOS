//
//  SettledTableViewCell.swift
//  CureitMobile
//
//  Created by mac on 20/03/25.
//

import UIKit

class SettledTableViewCell: UITableViewCell {
    @IBOutlet weak var orderTotalAmountLbl: UILabel!
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
        self.orderTotalAmountLbl.text = viewModel.totalAmount
    }
    
}
