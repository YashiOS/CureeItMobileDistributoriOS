//
//  HeaderTableViewCell.swift
//  CureitMobile
//
//  Created by mac on 27/03/25.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var headerLbl: UILabel!
    
    var viewModel: HeaderModel? {
        didSet {
            setupTitle()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }
    
    func setupTitle() {
        guard let viewModel = viewModel else { return }
        self.headerLbl.text = viewModel.headerTitle
    }

}

class HeaderModel {
    var titleString: String
    init(titleString: String) {
        self.titleString = titleString
    }
    
    var headerTitle: String {
        return titleString
    }
}
