//
//  EditCartViewModel.swift
//  NeoStoreApplication
//
//  Created by Minal Borole on 27/10/23.
//

import Foundation
import Alamofire

protocol DidEditedToCart: AnyObject {
    func didGetResponse(valid:Bool)
}
class EditCartViewModel {
    var delegate:DidEditedToCart?
    func checkEditedDataResponse(params:editToCartCred){
        let utility = Utility()
        let accessToken = GlobalInstance.shared.getAccessToken()
        let headers: HTTPHeaders = [
            "access_token": accessToken
        ]
        print(accessToken)
        utility.getPostData(url: apiUrl.editCartUrl, methodType: .post
                            , requestBody: params.asDictionary, responseModel: EditDeleteCartModel.self,headers:headers ) { result in
            switch result {
            case .success(let data):
                print("Success:", data ?? "")
                guard let data = data else{
                    return
                }
                self.delegate?.didGetResponse(valid: data.status == 200)
            case .failure(let error):
                print("Failed:", error)
            }
            
        }
    }
}
struct editToCartCred:Codable {
    let productId: Int?
    let quantity: String?
    
    var asDictionary: [String: Any] {
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            guard let jsonData = try? encoder.encode(self) else {
                return [:]
            }
            
            guard let jsonObject = try? JSONSerialization.jsonObject(with: jsonData, options: []) else {
                return [:]
            }
            
            if let dict = jsonObject as? [String: Any] {
                return dict
            } else {
                return [:]
            }
        }

}
