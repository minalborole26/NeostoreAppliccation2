//
//  ForgotPasswordViewController.swift
//  NeoStoreApplication
//
//  Created by Minal Borole on 30/10/23.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var emailView: ViewDesign!
    var viewModel : ForgotPasswordViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        placeholderColor()
        viewModel = ForgotPasswordViewModel()
        viewModel?.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NavigationManager.shared.createNavigationBar(from: self, forType: .back)
        NavigationManager.shared.isbackTapped = { [weak self]  in
            self?.navigationController?.popViewController(animated: true)
        }
        navigationItem.title = navigationTitle.forgotPassword
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    func placeholderColor() {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white
        ]
        let emailPlaceholder = NSAttributedString(string: placeHolder.email, attributes: attributes)
        email.attributedPlaceholder = emailPlaceholder
    }
    
    
    @IBAction func clickOnSubmitButton(_ sender: UIButton) {
        let para: [String:String] = ["email": email.text ?? ""]
        viewModel?.checkPassDataResponse(params: para)
    }
    
    
}
extension ForgotPasswordViewController: DidGetPassword {
    func didGetPass(valid: Bool, msg: String, userMsg: String) {
        let alertController = UIAlertController(title: msg, message: userMsg, preferredStyle: .alert)

        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            if valid {
                let vc = LoginViewController.instantiate(appStoryboard: .main)
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        alertController.addAction(okAction)

        self.present(alertController, animated: true, completion: nil)
    }
    
}
