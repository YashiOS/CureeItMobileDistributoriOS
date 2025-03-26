//
//  SettledTableViewCell.swift
//  CureitMobile
//
//  Created by mac on 20/03/25.
//

import UIKit

protocol SettledTableViewDelegate: AnyObject {
    func presentOrderDetailsVC(settledData: SettledDetailModel)
}
class SettledTableViewCell: UITableViewCell {
    @IBOutlet weak var orderTotalAmountLbl: UILabel!
    @IBOutlet weak var orderIdLbl: UILabel!
    var viewModel: SettledViewModel? {
        didSet {
            configureCell()
        }
    }
    
    weak var delegate: SettledTableViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
     
    }
    
    func configureCell() {
        guard let viewModel = viewModel else { return }
        self.orderIdLbl.text = viewModel.orderId
        self.orderTotalAmountLbl.text = viewModel.totalAmount
    }
    
    @IBAction func orderDetailsAction(_ sender: Any) {
        self.delegate?.presentOrderDetailsVC(settledData: self.viewModel!.settledData)
    }
}
