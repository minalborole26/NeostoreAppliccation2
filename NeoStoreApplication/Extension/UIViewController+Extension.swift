//
//  UIViewController+Extension.swift
//  NeoStoreApplication
//
//  Created by Minal Borole on 18/10/23.
//

import Foundation
import UIKit
extension UIStoryboard {
    static func getStoryboardController(name: String, controllerName: String) -> UIViewController {
        let storyboard = UIStoryboard(name: name,
                                      bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: controllerName)
     }
}
