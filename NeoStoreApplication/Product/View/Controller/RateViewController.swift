//
//  RateViewController.swift
//  NeoStoreApplication
//
//  Created by Minal Borole on 27/10/23.
//

import UIKit
import Cosmos

class RateViewController: UIViewController {

    @IBOutlet weak var rating: CosmosView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var name: UILabel!
    
    var data:String = ""
    var imgUrl: String?
    var productId: Int?
    var updatedRating: Int?
    var viewModel: SetRatingViewModel?
    var selectedRating : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        valueSetUp()
        viewModel = SetRatingViewModel()
        viewModel?.delegate = self
    }

    @IBAction func tabOnBackButton(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func tabOnRateNowBtn(_ sender: UIButton) {
        viewModel?.checkRatingData(productId:productId ?? 0 , rating: selectedRating ?? 0)
    }
    
    func valueSetUp() {
        name.text = data
        name.adjustsFontSizeToFitWidth = true
        name.minimumScaleFactor = 0.5
        imgView.loadImage(imgString: imgUrl ?? "")
        rating.settings.starSize = 40
        rating.didTouchCosmos = { rating in
            self.selectedRating = Int(rating)
        }
    }
    
}
extension RateViewController: RatingRes  {
    func didRatingSet(msg: String, userMsg: String) {
        let alertController = UIAlertController(title: msg, message: userMsg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            self.dismiss(animated: true)
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
