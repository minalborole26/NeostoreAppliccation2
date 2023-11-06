//
//  MyOrdersTableViewCell.swift
//  NeoStoreApplication
//
//  Created by Minal Borole on 03/11/23.
//

import UIKit

class MyOrdersTableViewCell: UITableViewCell {

    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var orderedDate: UILabel!
    @IBOutlet weak var orderId: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
