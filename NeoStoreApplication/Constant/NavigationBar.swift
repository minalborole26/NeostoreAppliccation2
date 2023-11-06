//
//  NavigationBar.swift
//  NeoStoreApplication
//
//  Created by Minal Borole on 18/10/23.
//

import Foundation
import UIKit
import SideMenu

enum NavigationType{
    case home
    case register
    case custom
    case back
    case address
}

class NavigationManager {
    //let sideMenuVC = HomeViewController()
    var isLeftBarTapped: ((Bool)->Void)?
    var isbackTapped: (()->Void)?
    var isPlusTapped: (()->Void)?

    static let shared = NavigationManager()
    // Singleton instance
    
    private init() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func menuSlider() {
        // sideMenuVC.loadSideMenu()
        isLeftBarTapped?(true)
    }
    @objc func searchBtn() {
        
    }
    @objc func backButtonTapped() {
        // Handle back button tap
        isbackTapped?()
    }
    @objc func addAddress() {
        isPlusTapped?()
    }
    func createNavigationBar(from sourceViewController: UIViewController, forType: NavigationType) {
        switch forType {
        case .home:
            let customBackButton = UIBarButtonItem(image: UIImage(named: "menu_icon"), style: .plain, target: self, action: #selector(menuSlider))
            customBackButton.tintColor = UIColor.white
            let customSearchButton = UIBarButtonItem(image: UIImage(named: "search_icon"), style: .plain, target: self, action: #selector(searchBtn))
            customSearchButton.tintColor = UIColor.white
            sourceViewController.navigationItem.leftBarButtonItem = customBackButton
            sourceViewController.navigationItem.rightBarButtonItem = customSearchButton
            
        case .register:
            sourceViewController.navigationController?.navigationBar.tintColor = UIColor.white
            sourceViewController.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
            
        case .custom:
            let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(backButtonTapped))
            backButton.title = ""
            backButton.tintColor = .white
            sourceViewController.navigationItem.leftBarButtonItem = backButton
            // Customize the appearance of the back button arrow color
//            sourceViewController.navigationController?.navigationBar.tintColor = .white
//            // Hide the back button title for the next view controller
//            sourceViewController.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
            let customSearchButton = UIBarButtonItem(image: UIImage(named: "search_icon"), style: .plain, target: self, action: #selector(searchBtn))
            customSearchButton.tintColor = UIColor.white
            sourceViewController.navigationItem.rightBarButtonItem = customSearchButton
            
        case .back:
            let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(backButtonTapped))
            backButton.title = ""
            backButton.tintColor = .white
            sourceViewController.navigationItem.leftBarButtonItem = backButton
            
        case .address:
            let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(backButtonTapped))
            backButton.title = ""
            backButton.tintColor = .white
            sourceViewController.navigationItem.leftBarButtonItem = backButton
            
            let customPlusButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addAddress))
            customPlusButton.tintColor = UIColor.white
            sourceViewController.navigationItem.rightBarButtonItem = customPlusButton
            
        }
    }
}
