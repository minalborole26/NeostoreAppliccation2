//
//  ProductDetailViewModel.swift
//  NeoStoreApplication
//
//  Created by Minal Borole on 25/10/23.
//

import Foundation

class ProductDetailViewModel {
    weak var delegate : DataPassing?
    var dataInDetail: ProductDetailsData?
    
    func checkGetData(id:Int)
    {
        let utility = Utility()
        let url = apiUrl.getProductDetailUrl+"\(id)"
        utility.getPostData(url: url, methodType: .get
                            , requestBody: [:], responseModel: ProductDetailModel.self) { result in
            switch result {
            case .success(let data):
                print("Success:", data ?? "")
                guard let data = data else{
                    return
                }
                self.dataInDetail = data.data
                self.delegate?.dataPass()
            case .failure(let error):
                print("Failed:", error)
            }
            
        }
        
    }
    func getProductDetailData() -> ProductDetailsData? {
        return self.dataInDetail
    }
}

