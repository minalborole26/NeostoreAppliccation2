//
//  CartManager.swift
//  NeoStoreApplication
//
//  Created by Minal Borole on 27/10/23.
//

import Foundation
class CartManager {
    static let shared = CartManager()
    private init() {}
    
    var cartItemCount: Int = 0
}
