//
//  LoginViewModel.swift
//  NeoStoreApplication
//
//  Created by Minal Borole on 18/10/23.
//

import Foundation
import Alamofire

protocol DidLoginRes: AnyObject {
    func didResData(valid: Bool)
}
class LoginViewModel {
    weak var delegate: DidLoginRes?
    func checkResponse(user: LoginCred) {
        let utility = Utility.shared
        
        utility.getPostData(url: apiUrl.loginUrl,
                            methodType: .post
                            ,requestBody: user.asDictionary,
                            responseModel: LoginResponse.self) { result in
            switch result {
            case .success(let data):
                print("Login successful:", data ?? "")
                let accessToken = data?.data?.accessToken
                GlobalInstance.shared.setAccessToken(accessToken: accessToken ?? "")
                self.delegate?.didResData(valid: data?.status == 200)
            case .failure(let error):
                print("Login failed:", error)
                
            }
        }
    }
}
