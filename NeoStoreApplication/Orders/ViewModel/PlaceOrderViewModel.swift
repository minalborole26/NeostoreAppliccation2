//
//  PlaceOrderViewModel.swift
//  NeoStoreApplication
//
//  Created by Minal Borole on 05/11/23.
//

import Foundation
import Alamofire
protocol DidOrderFetched: AnyObject {
    func didGetOrder(valid:Bool,msg:String,userMsg:String)
}
class PlaceOrderViewModel {
    var delegate : DidOrderFetched?
    
    func checkUserDataResponse(address:String){
        let utility = Utility()
        let accessToken = GlobalInstance.shared.getAccessToken()
        let headers: HTTPHeaders = [
            "access_token": accessToken
        ]
        print(accessToken)
        utility.getPostData(url: apiUrl.fetchOrderUrl, methodType: .post
                            , requestBody: ["address":address], responseModel: PlaceOrderModel.self,headers:headers ) { result in
            switch result {
            case .success(let data):
                print("Success:", data ?? "")
                guard let data = data else{
                    return
                }
                self.delegate?.didGetOrder(valid: data.status == 200 , msg: data.message ?? "", userMsg: data.userMsg ?? "")
            case .failure(let error):
                print("Failed:", error)
            }
        }
    }
}
