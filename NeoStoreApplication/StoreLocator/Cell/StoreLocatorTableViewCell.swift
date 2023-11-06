//
//  StoreLocatorTableViewCell.swift
//  NeoStoreApplication
//
//  Created by Minal Borole on 01/11/23.
//

import UIKit

class StoreLocatorTableViewCell: UITableViewCell {

    @IBOutlet weak var subname: UILabel!
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
