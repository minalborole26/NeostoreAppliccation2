//
//  UIStoryboard+Extension.swift
//  NeoStoreApplication
//
//  Created by Minal Borole on 18/10/23.
//

import Foundation
import UIKit

extension UIViewController {
    class func instantiate<T:UIViewController>(appStoryboard: AppStoryboard) -> T {
        let storyboard = UIStoryboard.init(name: appStoryboard.rawValue, bundle: nil);
        let identifier = String(describing: self)
        return storyboard.instantiateViewController(withIdentifier: identifier) as! T
    }
}
