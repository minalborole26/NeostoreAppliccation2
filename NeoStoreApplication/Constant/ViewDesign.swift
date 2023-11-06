//
//  ViewDesign.swift
//  NeoStoreApplication
//
//  Created by Minal Borole on 18/10/23.
//

import Foundation
import UIKit

class ViewDesign: UIView {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpUI()
    }
    
    func setUpUI() {
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.white.cgColor
        
    }
}
