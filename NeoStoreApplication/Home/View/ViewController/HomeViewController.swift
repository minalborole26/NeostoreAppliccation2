//
//  HomeViewController.swift
//  NeoStoreApplication
//
//  Created by Minal Borole on 19/10/23.
//

import UIKit
import SideMenu

class HomeViewController: UIViewController {

    @IBOutlet weak var productImgView: UICollectionView!
    @IBOutlet weak var ImageSliderView: UICollectionView!
    
    @IBOutlet weak var PageController: UIPageControl!
    let viewModel = HomeViewModel()
    let navigationManager = NavigationManager.shared
    var timer:Timer?
    var counter = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationManager.createNavigationBar(from: self, forType: .home)
        navigationManager.isLeftBarTapped = { [weak self] isleft in
            if isleft {
                self?.loadSideMenu()
            }
        }
        homeTimer()

        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = navigationTitle.neostore
    }
    
    func homeTimer() {
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(slideToNext), userInfo: nil, repeats: true)
        PageController.numberOfPages = arrName.imgArray.count
        PageController.currentPage = 0
    }
    @objc func slideToNext()
    {
        if counter < arrName.imgArray.count - 1 {
            counter = counter + 1
        }
        else {
            counter = 0
        }
        PageController.currentPage = counter
        ImageSliderView.scrollToItem(at: IndexPath(item: counter, section: 0), at: .right, animated: true)
    }
    

   
}
extension HomeViewController:UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.ImageSliderView  {
            return arrName.imgArray.count
        } else {
            return viewModel.getNumberOfRows()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = viewModel.getProductId(iIndex: indexPath.row)
        print(index)
        if collectionView == productImgView {
            if let productVC = self.storyboard?.instantiateViewController(withIdentifier: controllerName.ProductViewController) as? ProductViewController {
                productVC.productId = index
                self.navigationItem.title = ""
                self.navigationController?.pushViewController(productVC, animated: true)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == ImageSliderView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellConstant.cell, for: indexPath) as! ImageSliderCollectionViewCell
            cell.imgView.image = arrName.imgArray[indexPath.row]
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellConstant.cell, for: indexPath) as! HomeCollectionViewCell
            
            if let product = viewModel.getDataForIndexpath(iIndex: indexPath.row) {
                cell.imgView.image = product.image
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == ImageSliderView {
            return 0.0
        } else {
            return 10.0
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == ImageSliderView
        {
            return CGSize(width: ImageSliderView.frame.size.width, height: ImageSliderView.frame.size.height)
        }
        else {
            return CGSize(width: (collectionView.frame.width - 10) / 2, height: (collectionView.frame.height - 10) / 2)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

extension HomeViewController {
    func loadSideMenu(){
        let sideMenuController = UIStoryboard.getStoryboardController(name: storyBoardName.home,controllerName: controllerName.SideMenuViewController)
        let sideMenu = SideMenuNavigationController(rootViewController: sideMenuController)
        sideMenu.leftSide = true
        sideMenu.menuWidth = 300
        SideMenuManager.default.leftMenuNavigationController = sideMenu
        SideMenuManager.default.addPanGestureToPresent(toView: view)
        present(sideMenu, animated: true)
    }
}



