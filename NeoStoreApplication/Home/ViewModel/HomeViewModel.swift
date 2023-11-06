//
//  HomeViewModel.swift
//  NeoStoreApplication
//
//  Created by Minal Borole on 19/10/23.
//

import Foundation
class HomeViewModel {
    var productListContent: [productContent]?
    
    init() {
        getProduct()
    }
    
    func getProduct() {
        let list = productList()
        productListContent = list.productList
    }
    
    func getNumberOfRows() -> Int {
        return productListContent?.count ?? 0
    }
    
    func getDataForIndexpath(iIndex: Int) -> productContent? {
        return productListContent?[iIndex] ?? nil
    }
    
    func getProductId(iIndex: Int) -> Int {
        return productListContent?[iIndex].contentId ?? -1
    }
}
