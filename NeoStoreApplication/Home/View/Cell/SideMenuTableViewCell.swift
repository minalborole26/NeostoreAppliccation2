//
//  SideMenuTableViewCell.swift
//  NeoStoreApplication
//
//  Created by Minal Borole on 25/10/23.
//

import UIKit

class SideMenuTableViewCell: UITableViewCell {

    @IBOutlet weak var addToCartLabel: UILabel!
    @IBOutlet weak var badgeView: UIView!
    @IBOutlet weak var menuLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    var updatedCart: String = "" {
            didSet {
                addToCartLabel.text = updatedCart
            }
        }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
