//
//  IncomingOrderSelectionTableViewCell.swift
//  CureitMobile
//
//  Created by mac on 23/03/25.
//

import UIKit
import SDWebImage

protocol IncomingOrderSelectionTableViewCellDelegate: AnyObject {
    func didToggleSelection(for productId: String, isSelected: Bool)
}

class IncomingOrderSelectionTableViewCell: UITableViewCell {

    @IBOutlet weak var quantityLbl: UILabel!
    @IBOutlet weak var checkBoxBtn: UIButton!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var priceView: UIView!
    @IBOutlet weak var drugMarketerLbl: UILabel!
    @IBOutlet weak var drugNameLbl: UILabel!
    @IBOutlet weak var drugImage: UIImageView!
    
    var viewModel: IncomingOrdersDetailsViewModel? {
        didSet {
            configureCell()
        }
    }
    weak var delegate: IncomingOrderSelectionTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func setupUI() {
        self.priceView.layer.cornerRadius = 4
        self.checkBoxBtn.setImage(UIImage(systemName: "square"), for: .normal)
    }
    
    func configureCell() {
        guard let viewModel = viewModel else { return }
        self.drugNameLbl.text = viewModel.drugName
        self.drugMarketerLbl.text = ("by \(viewModel.drugMarketer)")
        self.priceLbl.text = ("₹\(viewModel.drugPrice)")
        self.quantityLbl.text = ("Qty:\(viewModel.drugQuantity)")
        if let imageUrl = URL(string: viewModel.drugImages) {
              self.drugImage.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: ""))
          }
    }
    
    @IBAction func checkBoxBtnAction(_ sender: Any) {
        let isSelected = checkBoxBtn.currentImage == UIImage(systemName: "square")
        checkBoxBtn.setImage(
            UIImage(systemName: isSelected ? "checkmark.square.fill" : "square"),
            for: .normal
        )
        delegate?.didToggleSelection(for: viewModel?.productId ?? "", isSelected: isSelected)

    }
    
}
