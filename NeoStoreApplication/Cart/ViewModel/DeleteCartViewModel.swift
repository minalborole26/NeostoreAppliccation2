//
//  DeleteCartViewModel.swift
//  NeoStoreApplication
//
//  Created by Minal Borole on 27/10/23.
//

import Foundation
import Alamofire
class DeleteCartViewModel {
    func checkDeletedDataResponse(productId:Int){
        let utility = Utility()
        let accessToken = GlobalInstance.shared.getAccessToken()
        let headers: HTTPHeaders = [
            "access_token": accessToken
        ]
        print(accessToken)
        utility.getPostData(url: apiUrl.deleteCartUrl, methodType: .post
                            , requestBody:["product_id": productId] , responseModel: EditDeleteCartModel.self,headers:headers ) { result in
            switch result {
            case .success(let data):
                print("Success:", data ?? "")
                guard let data = data else{
                    return
                }
            case .failure(let error):
                print("Failed:", error)
            }
            
        }
    }
}
