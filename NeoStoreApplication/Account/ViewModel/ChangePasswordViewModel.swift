//
//  ChangePasswordViewModel.swift
//  NeoStoreApplication
//
//  Created by Minal Borole on 02/11/23.
//

import Foundation
import Alamofire
protocol DidSetPassword: AnyObject {
    func didSetPass(valid:Bool,msg:String,userMsg:String)
}
class ChangePasswordViewModel {
    var delegate : DidSetPassword?
    
    func checkUserDataResponse(params:[String:String]){
        let utility = Utility()
        let accessToken = GlobalInstance.shared.getAccessToken()
        let headers: HTTPHeaders = [
            "access_token": accessToken
        ]
        print(accessToken)
        utility.getPostData(url: apiUrl.changePasswordUrl, methodType: .post
                            , requestBody:params , responseModel: ChangePasswordModel.self,headers:headers ) { result in
            switch result {
            case .success(let data):
                guard let data = data else{
                    return
                }
                print("Success:", data)
                self.delegate?.didSetPass(valid: data.status == 200, msg: data.message ?? "", userMsg: data.userMsg ?? "")
            case .failure(let error):
                print("Failed:", error)
            }
            
        }
    }
}
