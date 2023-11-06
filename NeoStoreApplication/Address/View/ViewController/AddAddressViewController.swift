//
//  AddAddressViewController.swift
//  NeoStoreApplication
//
//  Created by Minal Borole on 05/11/23.
//

import UIKit
import CoreData

class AddAddressViewController: UIViewController {

    @IBOutlet weak var country: UITextField!
    @IBOutlet weak var state: UITextField!
    @IBOutlet weak var zipcode: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var cityMain: UITextField!
    @IBOutlet weak var address: UITextView!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var viewModel: AddAddressViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        NavigationManager.shared.createNavigationBar(from: self, forType: .custom)
        viewModel = AddAddressViewModel()
        viewModel?.delegate = self

        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NavigationManager.shared.isbackTapped = { [weak self]  in
            self?.navigationController?.popViewController(animated: true)
        }
        navigationItem.title = navigationTitle.addAddress
    }

    @IBAction func tabOnSaveBtn(_ sender: UIButton) {
        let addressEntity = NSEntityDescription.entity(forEntityName: key.addressEntity,in: context)!
        let newAddress = NSManagedObject(entity: addressEntity, insertInto: context)
        newAddress.setValue(address.text, forKey: key.address)
        newAddress.setValue(cityMain.text, forKey: key.landmark)
        newAddress.setValue(city.text, forKey: key.city)
        newAddress.setValue(zipcode.text, forKey: key.zipcode)
        newAddress.setValue(state.text, forKey: key.state)
        newAddress.setValue(country.text, forKey: key.country)
        let isValid = viewModel?.validate(Address(address: address.text, landmark: cityMain.text, city: city.text, state: state.text, country: country.text, zipcode: zipcode.text)) ?? false
        
        if isValid == true {
            do {
                try context.save()
                print("Saved.")
                retriveAddress()
            }catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
    }
    func retriveAddress(){
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: key.addressEntity)
        do {
            let result = try context.fetch(fetchRequest) as! [AddressEntity]
            for data in result as [NSManagedObject] {
                print(data.value(forKey: key.address) as! String)
            }
            guard let vc = AddressListViewController.instantiate(appStoryboard: .address) as? AddressListViewController else { return }
            vc.result = result
            navigationController?.pushViewController(vc, animated: true)
        } catch {
            print("Failed")
        }
    }
    

}
extension AddAddressViewController: DidAddressCorrect {
    func didAddressGet(msg: String) {
        let alertController = UIAlertController(title: userMsg.fillAddress, message: msg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
