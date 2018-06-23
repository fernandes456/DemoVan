//
//  PickupOrderViewController.swift
//  DefaultProject
//
//  Created by Geraldo Fernandes on 23/06/18.
//  Copyright © 2018 Geraldo Fernandes. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps
import CoreLocation

class PickupViewController: UIViewController {
    
    @IBOutlet weak var orderLabel: UILabel!
    var presenter: PickupPresenter!
    @IBOutlet weak var bottomOrderDetailConstraint: NSLayoutConstraint!
    @IBOutlet weak var orderDetailHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var mapView: GMSMapView!
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.presenter = PickupPresenter(delegate: self)
        self.mapView.isMyLocationEnabled = true
        self.bottomOrderDetailConstraint.constant = self.orderDetailHeightConstraint.constant
        
        self.locationManager.delegate = self
        self.locationManager.startUpdatingLocation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter.start()
    }
    
    @IBAction func acceptOrder() {
        self.hideOrder()
    }
    
    @IBAction func declineOrder() {
        self.hideOrder()
    }
}

extension PickupViewController: PickupViewControllerType {
    var map: GMSMapView {
        return self.mapView
    }
    
    func showOrder(_ pickupOrder: PickupOrder) {
        UIView.animate(withDuration: 0.4) {
            self.bottomOrderDetailConstraint.constant = 0
        }
    }
    
    private func hideOrder() {
        UIView.animate(withDuration: 0.4) {
            self.bottomOrderDetailConstraint.constant = self.orderDetailHeightConstraint.constant
        }
    }
}

extension PickupViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last
        
        let camera = GMSCameraPosition.camera(withLatitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!, zoom: 17.0)
        
        self.mapView.animate(to: camera)
        
        self.locationManager.stopUpdatingLocation()
    }
}
