//
//  LoginViewController.swift
//  NeoStoreApplication
//
//  Created by Minal Borole on 18/10/23.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var forgotPassword: UILabel!
    @IBOutlet weak var loginPassword: UITextField!
    @IBOutlet weak var loginUserName: UITextField!
    @IBOutlet weak var passwordView: ViewDesign!
    @IBOutlet weak var userView: ViewDesign!
    var viewmodel: LoginViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()

        viewmodel = LoginViewModel()
        viewmodel?.delegate = self
        placeholderColor()
        imgTouched()
    }
    
    func placeholderColor() {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white
        ]
        loginUserName.attributedPlaceholder = NSAttributedString(string: placeHolder.userName, attributes: attributes)
        loginPassword.attributedPlaceholder = NSAttributedString(string: placeHolder.password, attributes: attributes)
    }
    
    func imgTouched() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped(_:)))
        forgotPassword.addGestureRecognizer(tapGesture)
        forgotPassword.isUserInteractionEnabled = true
    }
    
    @objc func labelTapped(_ sender: UITapGestureRecognizer) {
        let vc = ForgotPasswordViewController.instantiate(appStoryboard: .main)
        navigationController?.pushViewController(vc, animated: true)
    }
    

    @IBAction func loginBtnClicked(_ sender: UIButton) {
        let loginCredentials = LoginCred(email: "shital@gmail.com", password: "1234567")
//        let loginCredentials = LoginCred(email: loginUserName.text!, password: loginPassword.text!)
        
        viewmodel?.checkResponse(user: loginCredentials)
        
    }
    
    @IBAction func plusBtnClicked(_ sender: UIButton) {
//        let vc = storyboard?.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
//        navigationController?.pushViewController(vc, animated: true)
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        self.navigationController?.pushViewController(vc, animated: true)

    }
    
    func failureAlert() {
        let alertController = UIAlertController(title: userMsg.failureTitle,message: userMsg.failureMsg,preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            alertController.dismiss(animated: true)
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
}

extension LoginViewController: DidLoginRes {
    func didResData(valid: Bool) {
        if valid {
            let vc = HomeViewController.instantiate(appStoryboard: .home)
            navigationController?.pushViewController(vc, animated: true)
            
        }
        else {
            failureAlert()
        }
    }
    
}
