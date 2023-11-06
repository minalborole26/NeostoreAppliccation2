//
//  LoginResponse.swift
//  NeoStoreApplication
//
//  Created by Minal Borole on 18/10/23.
//

import Foundation

struct LoginResponse: Codable {
    let status: Int
    let data: UserData?
    let message: String
    let userMsg: String
    
    enum CodingKeys: String, CodingKey {
        case status
        case data
        case message
        case userMsg = "user_msg"
    }
}
