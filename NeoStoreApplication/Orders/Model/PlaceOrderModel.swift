//
//  PlaceOrderModel.swift
//  NeoStoreApplication
//
//  Created by Minal Borole on 05/11/23.
//

import Foundation
struct PlaceOrderModel : Codable {
    let status : Int?
    let message : String?
    let userMsg : String?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case message = "message"
        case userMsg = "user_msg"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        userMsg = try values.decodeIfPresent(String.self, forKey: .userMsg)
    }

}
