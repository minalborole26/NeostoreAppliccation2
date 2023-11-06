//
//  ViewController.swift
//  NeoStoreApplication
//
//  Created by Minal Borole on 18/10/23.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var firstName: UITextField!
    
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var FirstNameView: ViewDesign!
    
    @IBOutlet weak var LastNameView: ViewDesign!
    
    @IBOutlet weak var uncheckButton: UIButton!
    @IBOutlet weak var femaleButton: UIButton!
    
    @IBOutlet weak var maleButton: UIButton!
    @IBOutlet weak var phoneNumber: UITextField!
    
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phoneView: ViewDesign!
    @IBOutlet weak var ConfirmPasswordView: ViewDesign!
    @IBOutlet weak var PasswordView: ViewDesign!
    @IBOutlet weak var EmailView: ViewDesign!
    
    var gender: String?
    var checkFlag: Bool = false
    let selectedImage = UIImage(systemName: img.selectImg)
    let unselectedImage = UIImage(systemName: img.unselectImg)
    let checkImg = UIImage(named: img.checkImg)
    let uncheckImg = UIImage(named: img.uncheckImg)
    var viewmodel: RegisterViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewmodel = RegisterViewModel()
        viewmodel?.delegate = self
        placeholderColor()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NavigationManager.shared.createNavigationBar(from: self, forType: .register)
        NavigationManager.shared.isbackTapped = { [weak self]  in
            self?.navigationController?.popViewController(animated: true)
        }
        self.navigationItem.title = navigationTitle.register
        maleButton.tag = 1
        femaleButton.tag = 2
    }
    
    func placeholderColor() {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white
        ]
        firstName.attributedPlaceholder = NSAttributedString(string: placeHolder.firstName, attributes: attributes)
        lastName.attributedPlaceholder = NSAttributedString(string: placeHolder.lastName, attributes: attributes)
        email.attributedPlaceholder = NSAttributedString(string: placeHolder.email, attributes: attributes)
        password.attributedPlaceholder = NSAttributedString(string: placeHolder.password, attributes: attributes)
        confirmPassword.attributedPlaceholder = NSAttributedString(string: placeHolder.confirmPass, attributes: attributes)
        phoneNumber.attributedPlaceholder = NSAttributedString(string: placeHolder.phone, attributes: attributes)
    }

    @IBAction func selectGender(_ sender: UIButton) {
        if sender.tag == 1 {
            maleButton.setImage(selectedImage, for: .normal)
            femaleButton.setImage(unselectedImage, for: .normal)
            gender = cellConstant.male
        }
        else if sender.tag == 2 {
            maleButton.setImage(unselectedImage, for: .normal)
            femaleButton.setImage(selectedImage, for: .normal)
            gender = cellConstant.female
        }
    }
    
    @IBAction func CheckBtnClicked(_ sender: UIButton) {
        if checkFlag == true {
            uncheckButton.setImage(uncheckImg, for: .normal)
            checkFlag = false
        } else{
            checkFlag = true
            uncheckButton.setImage(checkImg, for: .normal)
        }
    }
    
    @IBAction func tapregisterBtnClicked(_ sender: UIButton) {
        let registerUser = User(firstName: self.firstName.text!, lastName: self.lastName.text!, email: self.email.text!, password: self.password.text!, confirmPassword: self.confirmPassword.text!, gender: self.gender,phoneNo: Int(self.phoneNumber.text ?? " "))
        let isValid = viewmodel?.validate(registerUser) ?? false
        if isValid == true {
            viewmodel?.checkResponse(user: registerUser, flag: checkFlag, valid: isValid)
        }
    }
    
    func successAlert(msg:String,userMsg:String,status:Bool) {
        let alertController = UIAlertController(title: msg, message:  userMsg, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            if status {

                let vc = LoginViewController.instantiate(appStoryboard: .main)
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func failureAlert(msg:String) {
        let alertController = UIAlertController(title: userMsg.registerFailed, message: msg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

extension RegisterViewController: DidReceivedRes {
    func didResData(msg: String, userMsg: String, valid: Bool) {
        successAlert(msg: msg, userMsg: userMsg, status: valid)
    }
    func didAPIFailed(msg:String) {
        failureAlert(msg: msg)
    }
}


