//
//  ProductDetailCollectionViewCell.swift
//  NeoStoreApplication
//
//  Created by Minal Borole on 25/10/23.
//

import UIKit

class ProductDetailCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                layer.borderWidth = 2.0
                layer.borderColor = UIColor.red.cgColor
            } else {
                layer.borderWidth = 2.0
                layer.borderColor = UIColor.white.cgColor
            }
        }
    }
}
