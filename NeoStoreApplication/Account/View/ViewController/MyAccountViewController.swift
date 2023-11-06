//
//  MyAccountViewController.swift
//  NeoStoreApplication
//
//  Created by Minal Borole on 02/11/23.
//

import UIKit

class MyAccountViewController: UIViewController {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var dob: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var dobView: ViewDesign!
    @IBOutlet weak var phoneView: ViewDesign!
    @IBOutlet weak var emailView: ViewDesign!
    @IBOutlet weak var lastNameView: ViewDesign!
    @IBOutlet weak var nameView: ViewDesign!
    var viewModel: GetAccountDetailsViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        NavigationManager.shared.createNavigationBar(from: self, forType: .custom)
        viewModel = GetAccountDetailsViewModel()
        viewModel?.delegate = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NavigationManager.shared.isbackTapped = { [weak self]  in
            self?.navigationController?.popViewController(animated: true)
        }
        self.navigationItem.title = navigationTitle.myAccount
        viewModel?.checkUserDataResponse()
    }
    
    @IBAction func clickOnEditButton(_ sender: UIButton) {
        let vc = EditProfileViewController.instantiate(appStoryboard: .account)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func clickOnResetBtn(_ sender: UIButton) {
        let vc = ChangePasswordViewController.instantiate(appStoryboard: .account)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
extension  MyAccountViewController: DidAccountFetched {
    func didGetAccount() {
        firstName.text = viewModel?.accountDetails?.firstName
        lastName.text = viewModel?.accountDetails?.lastName
        email.text = viewModel?.accountDetails?.email
        phone.text = viewModel?.accountDetails?.phoneNo
        dob.text = viewModel?.accountDetails?.dob
        imgView.loadImage(imgString: viewModel?.accountDetails?.profilePic ?? "")
    }
}
