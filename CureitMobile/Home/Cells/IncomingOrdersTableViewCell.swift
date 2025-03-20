//
//  IncomingOrdersTableViewCell.swift
//  CureitMobile
//
//  Created by mac on 20/03/25.
//

import UIKit

class IncomingOrdersTableViewCell: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var plusBtn: UIButton!
    @IBOutlet weak var plusBtnView: UIView!
    @IBOutlet weak var orderNumberLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func setupUI() {
        self.plusBtnView.layer.cornerRadius = 4
        self.plusBtn.setTitle("", for: .normal)
        self.mainView.layer.cornerRadius = 4
    }

    @IBAction func plusBtnAction(_ sender: Any) {
    }
}
