//
//  MyOrdersViewController.swift
//  NeoStoreApplication
//
//  Created by Minal Borole on 03/11/23.
//

import UIKit

class MyOrdersViewController: UIViewController {
    var viewModel: OrderListViewModel?

    @IBOutlet weak var tableView: UITableView!{
        didSet {
            tableView.register(UINib(nibName: cellConstant.MyOrdersTableViewCell, bundle: nil), forCellReuseIdentifier: cellConstant.MyOrdersTableViewCell)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        NavigationManager.shared.createNavigationBar(from: self, forType: .custom)
        viewModel = OrderListViewModel()
        viewModel?.checkCartList()
        viewModel?.delegate = self

        }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NavigationManager.shared.isbackTapped = { [weak self]  in
            self?.navigationController?.popViewController(animated: true)
        }
        navigationItem.title = navigationTitle.myOrders
    }
    
}
extension MyOrdersViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.orderDataArr?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellConstant.MyOrdersTableViewCell, for: indexPath) as! MyOrdersTableViewCell
        cell.selectionStyle = .none
        cell.orderId.text = "Order ID:\(viewModel?.getOrderData(index: indexPath.row)?.id ?? 0)"
        cell.orderedDate.text = "Ordered Date:\(viewModel?.getOrderData(index: indexPath.row)?.created ?? "")"
        cell.price.text = "₹.\(viewModel?.getOrderData(index: indexPath.row)?.cost ?? 0)"
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = OrderIdViewController.instantiate(appStoryboard: .orders) as? OrderIdViewController else { return }
        vc.orderId = viewModel?.getOrderData(index: indexPath.row)?.id
        navigationController?.pushViewController(vc, animated: true)
    }
}
extension MyOrdersViewController:DidOrdertListArrived {
    func didOrderUpdated() {
        tableView.reloadData()
    }
}
