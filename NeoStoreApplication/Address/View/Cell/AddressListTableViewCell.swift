//
//  AddressListTableViewCell.swift
//  NeoStoreApplication
//
//  Created by Minal Borole on 05/11/23.
//

import UIKit
import CoreData

class AddressListTableViewCell: UITableViewCell {

    @IBOutlet weak var view: UIView!
    @IBOutlet weak var selectBtn: UIButton!
    @IBOutlet weak var clearBtn: UIButton!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var name: UILabel!
    var onClickClearBtn: (() -> ())?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func awakeFromNib() {
        super.awakeFromNib()
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setup(useNname: String?, userAddress: String?,
               isSelect:Bool){
        name.text = useNname
        address.text = userAddress
        selectBtn.isUserInteractionEnabled = false
        let imageName = isSelect ? img.selectAddress : img.unselectImg
        selectBtn.setImage(UIImage(systemName: imageName),
                           for: .normal)
    }
    
    @IBAction func tapOnClearBtn(_ sender: UIButton) {
        onClickClearBtn?()
    }
}
