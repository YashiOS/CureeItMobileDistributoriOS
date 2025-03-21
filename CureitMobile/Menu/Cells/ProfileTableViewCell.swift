//
//  ProfileTableViewCell.swift
//  CureitMobile
//
//  Created by mac on 20/03/25.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var expandBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
     
    }
    
    func configureCell(with image: UIImage, title: String) {
            iconImageView.image = image
        cellTitle.text = title
        }
}
