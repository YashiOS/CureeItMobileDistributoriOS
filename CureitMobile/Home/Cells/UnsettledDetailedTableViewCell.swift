//
//  UnsettledDetailedTableViewCell.swift
//  CureitMobile
//
//  Created by mac on 20/03/25.
//

import UIKit
import SDWebImage

class UnsettledDetailedTableViewCell: UITableViewCell {
    @IBOutlet weak var orderTotalAmountLbl: UILabel!
    @IBOutlet weak var quantityLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var marketerLbl: UILabel!
    @IBOutlet weak var priceView: UIView!
    @IBOutlet weak var drugNameLbl: UILabel!
    @IBOutlet weak var drugImage: UIImageView!
    
    var viewModel: UnSettledDetailsViewModel? {
        didSet {
            configureCell()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func setupUI() {
        self.priceView.layer.cornerRadius = 4
    }
    
    func configureCell() {
        guard let viewModel = viewModel else { return }
        self.orderTotalAmountLbl.text = ("Total: \(viewModel.drugPrice)")
        self.quantityLbl.text = ("Qty:\(viewModel.drugQuantity)")
        self.priceLbl.text = ("₹\(viewModel.drugPrice)")
        self.marketerLbl.text = ("by \(viewModel.drugMarketer)")
        self.drugNameLbl.text = viewModel.drugName
        if let imageUrl = URL(string: viewModel.imageUrl) {
            self.drugImage.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: ""))
        }
    }
}
