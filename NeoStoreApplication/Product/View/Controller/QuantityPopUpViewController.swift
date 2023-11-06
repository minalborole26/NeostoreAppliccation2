//
//  QuantityPopUpViewController.swift
//  NeoStoreApplication
//
//  Created by Minal Borole on 26/10/23.
//

import UIKit

protocol PopupDelegate: AnyObject {
    func didSubmitFromPopup()
}

class QuantityPopUpViewController: UIViewController,UITextFieldDelegate {

   
  
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var quantity: UITextField!
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var View1: UIView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var backView: UIView!
    
    var data:String = ""
    var imgUrl: String?
    var productId: Int?
    weak var delegate: PopupDelegate?
    var viewModel: AddToCartViewModel?
    init() {
        super.init(nibName: controllerName.QuantityPopUpViewController, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = AddToCartViewModel()
        viewModel?.delegate = self
        valueSetUp()

        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        quantity.resignFirstResponder()
        return true
    }
    
    func valueSetUp() {
        let contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 40, right: 0)
        scrollView.contentInset = contentInset
        View1.layer.borderWidth = 2.0
        View1.layer.borderColor = UIColor.lightGray.cgColor
        quantity.layer.borderWidth = 2.0
        quantity.layer.borderColor = UIColor.green.cgColor
        quantity.delegate = self
        name.text = data
        imgView.loadImage(imgString: imgUrl ?? "")
    }

    @IBAction func tabOnSubmitButton(_ sender: UIButton) {
        let param = addToCartCred(productId: productId, quantity: quantity.text)
        viewModel?.checkDataResponse(params: param)
    }
    @IBAction func tabOnBackButton(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    

}
extension QuantityPopUpViewController: DidAddedToCart {
    func didGetRes(msg: String,userMsg: String,valid:Bool) {
        let alertController = UIAlertController(title: msg, message: userMsg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            if valid {
                self.delegate?.didSubmitFromPopup()
            }
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
