//
//  MyCartViewController.swift
//  NeoStoreApplication
//
//  Created by Minal Borole on 27/10/23.
//

import UIKit

class MyCartViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!{
        didSet {
            tableView.register(UINib(nibName: cellConstant.MyCartTableViewCell, bundle: nil), forCellReuseIdentifier: cellConstant.MyCartTableViewCell)
            tableView.register(UINib(nibName: cellConstant.CustomFooterView, bundle: nil), forHeaderFooterViewReuseIdentifier: cellConstant.CustomFooterView)
        }
    }
    
    var viewModel : CartListViewModel?
    var viewModel1 : EditCartViewModel?
    var viewModel2 : DeleteCartViewModel?
    var selectedIndex : String = ""
    var total : Int?
    var newSubTotal: Int?
    let footerView = UIView()
    var cartItemCount : Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = CartListViewModel()
        viewModel1 = EditCartViewModel()
        viewModel2 = DeleteCartViewModel()
        viewModel?.delegate = self
        viewModel1?.delegate = self
        viewModel?.checkCartList()

        }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = navigationTitle.myCart
        NavigationManager.shared.createNavigationBar(from: self, forType: .custom)
        NavigationManager.shared.isbackTapped = { [weak self]  in
            self?.navigationController?.popViewController(animated: true)
        }
    }
    
    func cartCount() {
        cartItemCount = viewModel?.cartDataArr?.count ?? 0
        CartManager.shared.cartItemCount  = cartItemCount
        print(cartItemCount)
    }
    

}
extension MyCartViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.cartDataArr?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellConstant.MyCartTableViewCell, for: indexPath) as! MyCartTableViewCell
        cell.imgView.loadImage(imgString: viewModel?.getCartData(index: indexPath.row)?.product?.productImages ?? "")
        cell.selectionStyle = .none
        cell.name.text = viewModel?.getCartData(index: indexPath.row)?.product?.name ?? ""
        cell.category.text = "(Category - \(viewModel?.getCartData(index: indexPath.row)?.product?.productCategory ?? ""))"
        cell.dropDown.text = "\(viewModel?.getCartData(index: indexPath.row)?.quantity ?? 0)"
        cell.price.text = "₹.\(viewModel?.getCartData(index: indexPath.row)?.product?.subTotal ?? 0)"
        cell.onDropdownSelection = { selectedItem in
            print("Selected item: \(selectedItem)")
            self.selectedIndex =  selectedItem
            let productId = self.viewModel?.getCartData(index: indexPath.row)?.productId
            let param = editToCartCred(productId: productId, quantity: selectedItem)
            self.viewModel1?.checkEditedDataResponse(params: param)
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if viewModel?.cartDataArr?.count == 0 || viewModel?.cartDataArr == nil{
            return nil
        }else{
            let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: cellConstant.CustomFooterView) as! CustomFooterView
            footerView.totalAmount.text = "₹.\(total ?? 0)"
            footerView.orderNowButton.addTarget(self, action: #selector(pressOrderNow), for: .touchUpInside)
            return footerView
        }
    }
    
    @objc func pressOrderNow(){
        let vc = AddressListViewController.instantiate(appStoryboard: .address)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 200
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            viewModel?.cartDataArr?.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { [weak self] (_, _, completionHandler) in
            
            if let productId = self?.viewModel?.getCartData(index: indexPath.row)?.productId {
                self?.viewModel2?.checkDeletedDataResponse(productId: productId)
                self?.viewModel?.cartDataArr?.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                GlobalInstance.shared.setCartCount(count: self?.viewModel?.cartDataArr?.count ?? 0)
                tableView.reloadData()
                
            }
            
            completionHandler(true)
        }
        
        if let binImage = UIImage(named: img.delete) {
            deleteAction.image = binImage
        }
        
        deleteAction.backgroundColor = .white
        
        let swipeActions = UISwipeActionsConfiguration(actions: [deleteAction])
        
        return swipeActions
    }
}
extension MyCartViewController: DidCartListArrived,DidEditedToCart {
    
    func didCartUpdated() {
        guard let totalCount = viewModel?.total else
        {
            return
        }
        self.total = totalCount
        GlobalInstance.shared.setCartCount(count: viewModel?.cartDataArr?.count ?? 0)
        tableView.reloadData()
    }
    
    func didGetResponse(valid: Bool) {
        if valid {
            viewModel?.checkCartList()
        }
    }
    
    func didCartEmpty() {
        let alertController = UIAlertController(title: userMsg.cartEmpty, message: userMsg.selectProduct, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            alertController.dismiss(animated: true)
        }
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}
