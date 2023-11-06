//
//  ProductTableViewCell.swift
//  NeoStoreApplication
//
//  Created by Minal Borole on 25/10/23.
//

import UIKit
import Cosmos

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var producer: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var stars: CosmosView!
    weak var delegate: TableViewCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    
    func configureWithRating(_ rating: Int) {
        title.adjustsFontSizeToFitWidth = true
        title.minimumScaleFactor = 0.5
        price.adjustsFontSizeToFitWidth = true
        price.minimumScaleFactor = 0.5
        stars.settings.updateOnTouch = false
        stars.settings.starSize = 18
        stars.settings.emptyBorderColor = UIColor.lightGray
        stars.settings.emptyColor = UIColor.lightGray
        stars.rating = Double(rating)

        }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
