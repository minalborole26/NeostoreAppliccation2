//
//  ProductViewController.swift
//  NeoStoreApplication
//
//  Created by Minal Borole on 25/10/23.
//

import UIKit
import Cosmos

class ProductViewController: UIViewController {

    @IBOutlet weak var productTableView: UITableView!
    var ratings: [Int] = [0,1,2,3,4,5]
    var viewmodel : ProductViewModel?
    var productId:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NavigationManager.shared.createNavigationBar(from: self, forType: .custom)
        NavigationManager.shared.isbackTapped = { [weak self]  in
            self?.navigationController?.popViewController(animated: true)
        }
        viewmodel = ProductViewModel()
        viewmodel?.delegate = self
        viewmodel?.checkGetData(id: productId ?? 0)

    }
    
    func NavBarTitleSetting(id:Int) {
        switch id {
        case 1:navigationItem.title = navigationTitle.tables
        case 2:navigationItem.title = navigationTitle.chairs
        case 3:navigationItem.title = navigationTitle.sofas
        case 4:navigationItem.title = navigationTitle.cupboards
        default:
            return
        }
    }
    }

extension ProductViewController:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewmodel?.dataArr?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellConstant.cell, for: indexPath) as! ProductTableViewCell
        let index = indexPath.row
        NavBarTitleSetting(id: viewmodel?.getProductData(index: index)?.productCategoryId ?? 0)
        cell.selectionStyle = .none
        cell.title.text = viewmodel?.getProductData(index: index)?.name
        cell.imgView.loadImage(imgString: viewmodel?.getProductData(index: index)?.productImages ?? "")
        cell.producer.text = viewmodel?.getProductData(index: index)?.producer
        cell.price.text = "RS.\(viewmodel?.getProductData(index: index)?.cost ?? 0)"
        cell.configureWithRating(viewmodel?.getProductData(index: index)?.rating ?? 0)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = viewmodel?.getProductData(index: indexPath.row)?.id ?? 0
        print(index)
        if let productDetailVC = self.storyboard?.instantiateViewController(withIdentifier: controllerName.ProductDetailViewController) as? ProductDetailViewController {
            productDetailVC.productId = index
            self.navigationController?.pushViewController(productDetailVC, animated: true)
        }
    }
}
extension ProductViewController: DataPassing {
    func dataPass() {
        productTableView.reloadData()
    }
}



