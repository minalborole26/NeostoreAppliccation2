//
//  OrderIdViewController.swift
//  NeoStoreApplication
//
//  Created by Minal Borole on 03/11/23.
//

import UIKit

class OrderIdViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!{
        didSet {
            tableView.register(UINib(nibName: cellConstant.OrderIdTableViewCell, bundle: nil), forCellReuseIdentifier: cellConstant.OrderIdTableViewCell)
            tableView.register(UINib(nibName: cellConstant.OrderIdFooterView, bundle: nil), forHeaderFooterViewReuseIdentifier: cellConstant.OrderIdFooterView)
        }
    }
    var orderId:Int?
    var price: Int?
   var viewModel:OrderDetailViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        NavigationManager.shared.createNavigationBar(from: self, forType: .custom)
        viewModel = OrderDetailViewModel()
        viewModel?.delegate = self
        viewModel?.checkGetData(id: orderId ?? 0)

        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Order ID : \(orderId ?? 0)"
    }

    

}
extension OrderIdViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.dataArr?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellConstant.OrderIdTableViewCell, for: indexPath) as! OrderIdTableViewCell
        cell.selectionStyle = .none
        cell.imgView.loadImage(imgString: viewModel?.getOrderDetailData(index: indexPath.row)?.prodImage ?? "")
        cell.name.text = viewModel?.getOrderDetailData(index: indexPath.row)?.prodName
        cell.category.text = "(\(viewModel?.getOrderDetailData(index: indexPath.row)?.prodCatName ?? ""))"
        cell.quantity.text = "QTY : \(viewModel?.getOrderDetailData(index: indexPath.row)?.quantity ?? 0)"
        cell.price.text = "₹.\(viewModel?.getOrderDetailData(index: indexPath.row)?.total ?? 0)"
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: cellConstant.OrderIdFooterView) as! OrderIdFooterView
        footerView.totalCost.text = "₹. \(viewModel?.cost ?? 0)"
        return footerView
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 100
    }
}
extension OrderIdViewController: OrderDataPassing {
    func orderPass() {
        tableView.reloadData()
    }
}
