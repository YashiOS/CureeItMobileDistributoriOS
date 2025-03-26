//
//  OrderListDetailsTableViewCell.swift
//  CureitMobile
//
//  Created by mac on 24/03/25.
//

import UIKit

class OrderListDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var drugPriceLbl: UILabel!
    @IBOutlet weak var quantityLbl: UILabel!
    @IBOutlet weak var drugNameLbl: UILabel!
    
    var viewModel: OrderListDetailsViewModel? {
        didSet {
            configureCell()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    func configureCell() {
        guard let viewModel = viewModel else { return }
        self.drugNameLbl.text = viewModel.drugName
        self.quantityLbl.text = ("\(viewModel.drugQuantity) Strips")
        self.drugPriceLbl.text = viewModel.drugPrice
    }
}
