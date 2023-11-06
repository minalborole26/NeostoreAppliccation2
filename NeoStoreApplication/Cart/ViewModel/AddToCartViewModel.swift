//
//  AddToCartViewModel.swift
//  NeoStoreApplication
//
//  Created by Minal Borole on 26/10/23.
//

import Foundation
import Alamofire
protocol DidAddedToCart: AnyObject {
    func didGetRes(msg:String,userMsg: String,valid:Bool)
}
class AddToCartViewModel {
    weak var delegate: DidAddedToCart?
    func checkDataResponse(params:addToCartCred){
        let utility = Utility()
        let accessToken = GlobalInstance.shared.getAccessToken()
        let headers: HTTPHeaders = [
            "access_token": accessToken
        ]
        print(accessToken)
        utility.getPostData(url: apiUrl.addToCartUrl, methodType: .post
                            , requestBody: params.asDictionary, responseModel: AddToCartModel.self,headers:headers ) { result in
            switch result {
            case .success(let data):
                print("Success:", data ?? "")
                guard let data = data else{
                    return
                }
                self.delegate?.didGetRes(msg: data.message ?? "Not Added To Cart",userMsg: data.userMsg ?? "failed",valid: data.status == 200)
            case .failure(let error):
                print("Failed:", error)
            }
            
        }
        
    }
}
