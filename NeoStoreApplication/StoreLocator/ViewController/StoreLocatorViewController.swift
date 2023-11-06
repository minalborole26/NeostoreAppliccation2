//
//  StoreLocatorViewController.swift
//  NeoStoreApplication
//
//  Created by Minal Borole on 01/11/23.
//

import UIKit
import MapKit

class StoreLocatorViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!{
        didSet {
            tableView.register(UINib(nibName: cellConstant.StoreLocatorTableViewCell, bundle: nil), forCellReuseIdentifier: cellConstant.StoreLocatorTableViewCell)
        }
    }
    let stores = [
        Store(title:"GrandHighStreet Mall" , subTitle: "Shop No 6 , Crowford Market, Mumbai, India", coordinate: CLLocationCoordinate2D(latitude: 18.948366, longitude: 72.825935)),
        Store(title:"Phoenix Store", subTitle: "Phoenix Marketcity, Bengaluru, India", coordinate: CLLocationCoordinate2D(latitude: 12.995854, longitude: 77.696350)),
        Store(title:"Sigma Park" , subTitle: "Orion Mall, Kolkata, India", coordinate: CLLocationCoordinate2D(latitude: 22.5874 , longitude: 88.4082)),
        Store(title:"UP Store" , subTitle: "DLF Mall of India, Uttar Pradesh, India", coordinate: CLLocationCoordinate2D(latitude: 28.567190, longitude: 77.320892))
    ]
    @IBOutlet weak var mapView: MKMapView!
    var annotation : MKPointAnnotation?
    override func viewDidLoad() {
        super.viewDidLoad()
        NavigationManager.shared.createNavigationBar(from: self, forType: .custom)
        NavigationManager.shared.isbackTapped = { [weak self]  in
            self?.navigationController?.popViewController(animated: true)
        }
        navigationItem.title = navigationTitle.store
        annotation = MKPointAnnotation()
        for location in stores {
            mapView.addAnnotation(location)
        }

        
    }
    
  }

class Store: NSObject, MKAnnotation {
    let title: String?
    let subTitle: String?
    let coordinate: CLLocationCoordinate2D
    init(title: String,subTitle:String,coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subTitle = subTitle
        self.coordinate = coordinate
        super.init()
    }
}
extension StoreLocatorViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellConstant.StoreLocatorTableViewCell, for: indexPath) as! StoreLocatorTableViewCell
        cell.selectionStyle = .none
        cell.name.text = stores[indexPath.row].title
        cell.subname.text = stores[indexPath.row].subTitle
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        annotation?.coordinate = stores[indexPath.row].coordinate
        let region = MKCoordinateRegion(center: annotation?.coordinate ?? CLLocationCoordinate2D(latitude: 20.5937, longitude: 78.9629), latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
        mapView.addAnnotation(annotation!)
        
    }
}
