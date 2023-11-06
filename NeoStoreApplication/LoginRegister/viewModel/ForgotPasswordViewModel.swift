//
//  ForgotPasswordViewModel.swift
//  NeoStoreApplication
//
//  Created by Minal Borole on 30/10/23.
//

import Foundation
protocol DidGetPassword: AnyObject {
    func didGetPass(valid:Bool,msg:String,userMsg:String)
}
class ForgotPasswordViewModel {
    var delegate : DidGetPassword?
    
    func checkPassDataResponse(params:[String:String]){
        let utility = Utility()
        utility.getPostData(url: apiUrl.forgotPasswordUrl, methodType: .post
                            , requestBody:params , responseModel: ChangePasswordModel.self ) { result in
            switch result {
            case .success(let data):
                guard let data = data else{
                    return
                }
                print("Success:", data)
                self.delegate?.didGetPass(valid: data.status == 200, msg: data.message ?? "", userMsg: data.userMsg ?? "")
            case .failure(let error):
                print("Failed:", error)
            }
            
        }
    }
}
