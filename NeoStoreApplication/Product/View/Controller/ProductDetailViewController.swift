//
//  ProductDetailViewController.swift
//  NeoStoreApplication
//
//  Created by Minal Borole on 25/10/23.
//

import UIKit
import Cosmos
class ProductDetailViewController: UIViewController {

    @IBOutlet weak var detailDescription: UILabel!
    @IBOutlet weak var cost: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var productImgDetail: UIImageView!
    @IBOutlet weak var starsView: CosmosView!
    @IBOutlet weak var producer: UILabel!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var productTitle: UILabel!
    var productId:Int?
    var viewmodel: ProductDetailViewModel?
    var popUp: QuantityPopUpViewController?
    var ratePopUp: RateViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        NavigationManager.shared.createNavigationBar(from: self, forType: .custom)
        viewmodel = ProductDetailViewModel()
        viewmodel?.delegate = self

       
    }
    override func viewDidAppear(_ animated: Bool) {
        viewmodel?.checkGetData(id: productId ?? 0)
    }
    
    func cellData(categoryId:Int)
    {
        switch categoryId {
        case 1: category.text = categoryName.table
        case 2: category.text = categoryName.chairs
        case 3: category.text = categoryName.sofas
        case 4: category.text = categoryName.cupboards
        default:
            return
        }
        
    }
    
    func setupWithRating(_ rating: Int) {
        starsView.settings.updateOnTouch = false
        starsView.settings.starSize = 18
        starsView.settings.emptyBorderColor = UIColor.lightGray
        starsView.settings.emptyColor = UIColor.lightGray
        starsView.rating = Double(rating)
    }
    
    func setUpValue() {
        self.title = viewmodel?.getProductDetailData()?.name
        productTitle.text = viewmodel?.getProductDetailData()?.name
        productTitle.adjustsFontSizeToFitWidth = true
        productTitle.minimumScaleFactor = 0.5
        guard let categoryId = viewmodel?.getProductDetailData()?.productCategoryId else { return }
        cellData(categoryId: categoryId)
        producer.text = viewmodel?.getProductDetailData()?.producer
        cost.text = "Rs. \(viewmodel?.getProductDetailData()?.cost ?? 0)"
        productImgDetail.loadImage(imgString: viewmodel?.getProductDetailData()?.productImages?.first?.image ?? "")
        setupWithRating(viewmodel?.getProductDetailData()?.rating ?? 0)
        detailDescription.text = viewmodel?.getProductDetailData()?.description
        let frame = CGRect(x: 0, y: 0, width: 200, height: 40)
        let tlabel = UILabel(frame: frame)
        tlabel.text = self.title
        tlabel.textColor = UIColor.white
        tlabel.font = UIFont.boldSystemFont(ofSize: 24)
        tlabel.backgroundColor = UIColor.clear
        tlabel.adjustsFontSizeToFitWidth = true
        tlabel.textAlignment = .center
        self.navigationItem.titleView = tlabel
    }

    @IBAction func clickOnBuyNow(_ sender: UIButton) {
        
        popUp = QuantityPopUpViewController()
        popUp?.modalPresentationStyle = .overFullScreen
        popUp?.delegate = self
        popUp?.data = viewmodel?.getProductDetailData()?.name ?? ""
        popUp?.productId = viewmodel?.getProductDetailData()?.id ?? 0
        if let imageUrl = viewmodel?.getProductDetailData()?.productImages?.first?.image {
            popUp?.imgUrl = imageUrl
        }
        self.present(popUp ?? UIViewController(),animated: true,completion: nil)
        
    }
    
    @IBAction func clickOnRateNow(_ sender: UIButton) {
        ratePopUp = RateViewController()
        ratePopUp?.modalPresentationStyle = .overFullScreen
        ratePopUp?.data = viewmodel?.getProductDetailData()?.name ?? ""
        ratePopUp?.productId = viewmodel?.getProductDetailData()?.id ?? 0
        if let imageUrl = viewmodel?.getProductDetailData()?.productImages?.first?.image {
            ratePopUp?.imgUrl = imageUrl
        }
        self.present(ratePopUp ?? UIViewController(),animated: true,completion: nil)
    }
    
}

extension ProductDetailViewController :UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewmodel?.getProductDetailData()?.productImages?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ProductDetailCollectionViewCell
        cell.imgView.loadImage(imgString: viewmodel?.getProductDetailData()?.productImages?[indexPath.item].image ?? "")
        return cell ?? UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        productImgDetail.loadImage(imgString: viewmodel?.getProductDetailData()?.productImages?[indexPath.row].image ?? "")
        let cell = collectionView.cellForItem(at: indexPath) as? ProductDetailCollectionViewCell
        cell?.isSelected = true
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.size.width / 3, height: collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10        }
    
}
extension ProductDetailViewController: DataPassing {
    func dataPass() {
        setUpValue()
        collectionView.reloadData()
    }
    
}
extension ProductDetailViewController: PopupDelegate {
    func didSubmitFromPopup() {
        popUp?.dismiss(animated: true)
        let vc = MyCartViewController.instantiate(appStoryboard: .home)
        navigationController?.pushViewController(vc, animated: true)
    }
}
