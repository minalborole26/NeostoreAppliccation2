//
//  OrderListViewModel.swift
//  NeoStoreApplication
//
//  Created by Minal Borole on 03/11/23.
//

import Foundation
import Alamofire
protocol DidOrdertListArrived: AnyObject {
    func didOrderUpdated()
}
class OrderListViewModel {
    weak var delegate: DidOrdertListArrived?
    var orderDataArr : [OrderListData]?
    func checkCartList(){
        let utility = Utility()
        let accessToken = GlobalInstance.shared.getAccessToken()
        let headers: HTTPHeaders = [
            "access_token": accessToken
        ]
        print(accessToken)
        utility.getPostData(url: apiUrl.orderListUrl, methodType: .get
                            , requestBody: [:], responseModel: OrderListModel.self, headers:headers ) { result in
            switch result {
            case .success(let data):
                print("Success:", data ?? "")
                guard let data = data else{
                    return
                }
                self.orderDataArr = data.data
                self.delegate?.didOrderUpdated()
            case .failure(let error):
                print("Failed:", error)
            }
        }
    }
    func getOrderData(index:Int) -> OrderListData? {
        return self.orderDataArr?[index]
    }
}
