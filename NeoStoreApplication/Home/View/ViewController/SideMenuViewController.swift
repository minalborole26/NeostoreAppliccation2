//
//  SideMenuViewController.swift
//  NeoStoreApplication
//
//  Created by Minal Borole on 25/10/23.
//

import UIKit

class SideMenuViewController: UIViewController {

    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var sideMenuTableView: UITableView!{
        didSet {
            sideMenuTableView.register(UINib(nibName: cellConstant.SideMenuTableViewCell, bundle: nil), forCellReuseIdentifier: cellConstant.SideMenuTableViewCell)
        }
    }
    
    var viewModel : SideMenuViewModel?
    var viewModel1 : GetAccountDetailsViewModel?
    var updatedCart: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = SideMenuViewModel()
        viewModel?.delegate = self
        viewModel1 = GetAccountDetailsViewModel()
        viewModel?.checkGetData()
        updatedCart = "\(GlobalInstance.shared.getCartCount())"

        }
    func menuLoader() {
        profileImg.layer.masksToBounds = true
        profileImg.layer.cornerRadius = profileImg.frame.size.width / 2
        profileImg?.layer.borderWidth = 3.0
        profileImg?.layer.borderColor = UIColor.white.cgColor
        name.text = "\(viewModel?.dataArr?.userData.firstName ?? "") \(viewModel?.dataArr?.userData.lastName ?? "")"
        email.text = viewModel?.dataArr?.userData.email
        profileImg.loadImage(imgString: viewModel?.dataArr?.userData.profilePic ?? "")
    }
    
    func didSelectMenuItem(id:Int) {
        guard let vc = ProductViewController.instantiate(appStoryboard: .home) as? ProductViewController else { return }
        vc.productId = id
        self.navigationItem.title = ""
        navigationController?.pushViewController(vc, animated: true)
    }

   

}
extension SideMenuViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrName.menuImgArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellConstant.SideMenuTableViewCell, for: indexPath) as! SideMenuTableViewCell
        cell.selectionStyle = .none
        cell.imgView.image = arrName.menuImgArr[indexPath.row]
        cell.menuLabel.text = arrName.menuArr[indexPath.row]
        if indexPath.row == 0 {
            cell.addToCartLabel.text = updatedCart
            cell.badgeView.isHidden = false
        } else {
            cell.badgeView.isHidden = true
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let vc = MyCartViewController.instantiate(appStoryboard: .home)
            viewModel1?.checkUserDataResponse()
            navigationController?.pushViewController(vc, animated: true)
        case 1,2,3,4:
            let index = viewModel?.dataArr?.productCategories[indexPath.row-1].id
            didSelectMenuItem(id: index ?? 0)
        case 5:
            let vc = MyAccountViewController.instantiate(appStoryboard: .account)
            navigationController?.pushViewController(vc, animated: true)
        case 6:
            let vc = StoreLocatorViewController.instantiate(appStoryboard: .storeLocator)
            navigationController?.pushViewController(vc, animated: true)
        case 7:
            let vc = MyOrdersViewController.instantiate(appStoryboard: .orders)
            navigationController?.pushViewController(vc, animated: true)
        case 8:
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate,
               let window = appDelegate.window {
                let storyboard = UIStoryboard(name: storyBoardName.main, bundle: nil)
                let rootViewController = storyboard.instantiateInitialViewController()
                window.rootViewController = rootViewController
            }
        default:
            return
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75.0
    }
}

extension SideMenuViewController: DataPass {
    func dataPassing() {
        menuLoader()
        sideMenuTableView.reloadData()
    }
}


