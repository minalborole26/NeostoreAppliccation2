//
//  EditProfileViewController.swift
//  NeoStoreApplication
//
//  Created by Minal Borole on 02/11/23.
//

import UIKit

class EditProfileViewController: UIViewController {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameView: ViewDesign!
    
    @IBOutlet weak var lastNameView: ViewDesign!
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var dobView: ViewDesign!
    
   
    @IBOutlet weak var dob: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var phoneView: ViewDesign!
    @IBOutlet weak var emailView: ViewDesign!
    var getAccountDetailsViewModel:GetAccountDetailsViewModel?
    var updateAccountViewModel: UpdateAccountViewModel?
    let datePicker = UIDatePicker()
    override func viewDidLoad() {
        super.viewDidLoad()
        NavigationManager.shared.createNavigationBar(from: self, forType: .custom)
        imgTapGesture()
        setupViewModel()
        showDatePicker()
       
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NavigationManager.shared.isbackTapped = { [weak self]  in
            self?.navigationController?.popViewController(animated: true)
        }
        self.navigationItem.title = navigationTitle.editProfile
    }
    func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        
        //done button & cancel button
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(donedatePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(donedatePicker))
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        // add toolbar to textField
        dob.inputAccessoryView = toolbar
        // add datepicker to textField
        dob.inputView = datePicker
        
    }
    @objc func donedatePicker(){
        //For date formate
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        dob.text = formatter.string(from: datePicker.date)
        //dismiss date picker dialog
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    func imgTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        imgView.addGestureRecognizer(tapGesture)
        imgView.isUserInteractionEnabled = true
    }
    @objc func imageTapped() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    @IBAction func clickOnSubmitBtn(_ sender: UIButton) {
        guard let imageData = imgView.image?.jpegData(compressionQuality: 0.2) else { return }
        print(imageData)
        let baseString = cellConstant.baseString+imageData.base64EncodedString()
        print(baseString)
        let newCred = UpdateCred(first_name: firstName.text, lastName: lastName.text, email: email.text, dob: dob.text, profile_pic: baseString , phoneNo: phone.text)
        updateAccountViewModel?.checkUpdatedDataResponse(params: newCred)
    }
    private func setupViewModel() {
        getAccountDetailsViewModel = GetAccountDetailsViewModel()
        getAccountDetailsViewModel?.delegate = self
        getAccountDetailsViewModel?.checkUserDataResponse()
        
        updateAccountViewModel = UpdateAccountViewModel()
        updateAccountViewModel?.delegate = self
    }
   

}
extension EditProfileViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imgView.image = selectedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
extension EditProfileViewController: DidAccountUpdate {
    func didAccountUpdated(valid: Bool, msg: String, userMsg: String) {
        let alertController = UIAlertController(title: msg,
                                                message: userMsg,
                                                preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            if valid {
                self.navigationController?.popViewController(animated: true)
            }
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
extension EditProfileViewController : DidAccountFetched {
    func didGetAccount() {
        firstName.text = getAccountDetailsViewModel?.accountDetails?.firstName
        lastName.text = getAccountDetailsViewModel?.accountDetails?.lastName
        email.text = getAccountDetailsViewModel?.accountDetails?.email
        phone.text = getAccountDetailsViewModel?.accountDetails?.phoneNo
        dob.text = getAccountDetailsViewModel?.accountDetails?.dob
        imgView.loadImage(imgString: getAccountDetailsViewModel?.accountDetails?.profilePic ?? "")
    }
}

