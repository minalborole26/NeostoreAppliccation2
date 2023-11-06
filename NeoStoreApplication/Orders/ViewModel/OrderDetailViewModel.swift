//
//  OrderDetailViewModel.swift
//  NeoStoreApplication
//
//  Created by Minal Borole on 03/11/23.
//

import Foundation
import Alamofire
protocol OrderDataPassing : AnyObject {
    func orderPass()
}
class OrderDetailViewModel {
    weak var delegate : OrderDataPassing?
    var cost: Int?
    var dataArr: [OrderDetails]?
   
    func checkGetData(id:Int)
    {
        let utility = Utility()
        let accessToken = GlobalInstance.shared.getAccessToken()
        let headers: HTTPHeaders = [
            "access_token": accessToken
        ]
        print(accessToken)
        utility.getPostData(url: apiUrl.orderDetailUrl, methodType: .get
                            , requestBody: ["order_id":id], responseModel: OrderDetailModel.self,headers: headers) { result in
            switch result {
            case .success(let data):
                print("Success:", data ?? "")
                guard let data = data else{
                    return
                }
                self.dataArr = data.data?.orderDetails
                self.cost = data.data?.cost
                self.delegate?.orderPass()
            case .failure(let error):
                print("Failed:", error)
            }
        }
    }
    func getOrderDetailData(index:Int) -> OrderDetails? {
        return self.dataArr?[index]
    }
}

