//
//  SideMenuViewModel.swift
//  NeoStoreApplication
//
//  Created by Minal Borole on 25/10/23.
//

import Foundation
import Alamofire

protocol DataPass: AnyObject {
    func dataPassing()
}
class SideMenuViewModel {
    weak var delegate : DataPass?
    var dataArr: DataClass?
    func checkGetData()
    {
        let utility = Utility()
        let url = apiUrl.fetchProfileUrl
        let accessToken = GlobalInstance.shared.getAccessToken()
        let headers: HTTPHeaders = [
            "access_token": accessToken
        ]
        print(accessToken)
        utility.getPostData(url: url,isSnakecase: true, methodType: .get, requestBody: [:],responseModel: SideMenu.self, headers:headers) { result in
            switch result {
            case .success(let data):
                print("Success:", data ?? "")
                guard let data = data else{
                    return
                }
               self.dataArr = data.data
                self.delegate?.dataPassing()
            case .failure(let error):
                print("Failed:", error)
            }
            
        }
        
    }
}



