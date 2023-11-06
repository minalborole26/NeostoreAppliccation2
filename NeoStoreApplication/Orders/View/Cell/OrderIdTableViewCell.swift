//
//  OrderIdTableViewCell.swift
//  NeoStoreApplication
//
//  Created by Minal Borole on 03/11/23.
//

import UIKit

class OrderIdTableViewCell: UITableViewCell {

    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var quantity: UILabel!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
