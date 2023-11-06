//
//  AddressModel.swift
//  NeoStoreApplication
//
//  Created by Minal Borole on 03/11/23.
//

import Foundation
struct Address {
    var address:String?
    var landmark:String?
    var city:String?
    var state:String?
    var country:String?
    var zipcode:String?
    var isSelected:Bool?
    init(address: String?, landmark: String?, city: String?, state: String?, country: String?, zipcode: String?) {
        self.address = address
        self.landmark = landmark
        self.city = city
        self.state = state
        self.country = country
        self.zipcode = zipcode
    }
}

