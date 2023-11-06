//
//  MyCartTableViewCell.swift
//  NeoStoreApplication
//
//  Created by Minal Borole on 27/10/23.
//

import UIKit
import iOSDropDown

class MyCartTableViewCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var dropDown: DropDown!
    
    @IBOutlet weak var price: UILabel!
    var index: Int = 0
    var onDropdownSelection: ((String) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        dropDown.endEditing(true)
        dropDownSetup()
        dropDown.optionArray = ["1","2","3","4","5","6","7","8"]
        dropDown.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showList)))
        dropDown.didSelect { [weak self] (selectedItem, _, _) in
            self?.onDropdownSelection?(selectedItem)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @objc func showList(){
        dropDown.showList()
    }
    func dropDownSetup() {
        let imageView = UIImageView(frame: CGRect(x: 5, y: 5, width: 15, height: 10))
        imageView.image = UIImage(systemName: img.downarrow)
        imageView.tintColor = .black
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 20))
        containerView.addSubview(imageView)
        dropDown.rightView = containerView
        dropDown.rightViewMode = .always
    }
}
