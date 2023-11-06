//
//  ChangePasswordViewController.swift
//  NeoStoreApplication
//
//  Created by Minal Borole on 02/11/23.
//

import UIKit

class ChangePasswordViewController: UIViewController {

    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var newPassword: UITextField!
    @IBOutlet weak var currentPassword: UITextField!
    @IBOutlet weak var view3: ViewDesign!
    @IBOutlet weak var view2: ViewDesign!
    @IBOutlet weak var view1: ViewDesign!
    var viewModel: ChangePasswordViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NavigationManager.shared.createNavigationBar(from: self, forType: .back)
        placeholderColor()
        viewModel = ChangePasswordViewModel()
        viewModel?.delegate = self

        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NavigationManager.shared.isbackTapped = { [weak self]  in
            self?.navigationController?.popViewController(animated: true)
        }
        navigationItem.title = navigationTitle.resetPass
    }

    func placeholderColor() {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white
        ]
        currentPassword.attributedPlaceholder = NSAttributedString(string: key.currentPass, attributes: attributes)
        newPassword.attributedPlaceholder = NSAttributedString(string: key.newPass, attributes: attributes)
        confirmPassword.attributedPlaceholder = NSAttributedString(string: key.confirmPass, attributes: attributes)
    }

    @IBAction func clickOnResetButton(_ sender: UIButton) {
        let params:[String:String] = ["old_password":currentPassword.text!,
                                      "password":newPassword.text!,
                                      "confirm_password":confirmPassword.text!]
        viewModel?.checkUserDataResponse(params: params)
    }
}
extension ChangePasswordViewController: DidSetPassword {
    func didSetPass(valid: Bool, msg: String, userMsg: String) {
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
