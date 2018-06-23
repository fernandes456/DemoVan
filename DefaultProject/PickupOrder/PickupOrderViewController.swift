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

protocol PickupViewControllerType: class {
    func showOrder(_ viewModel: PickupOrderViewModel)
    var map: GMSMapView { get }
    func centerMap(location: CLLocation)
    func showPoyline(polyline: GMSPolyline)
}

class PickupViewController: UIViewController {
    
    @IBOutlet weak var pickupUntilLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var orderLabel: UILabel!
    var presenter: PickupPresenterType!
    @IBOutlet weak var bottomOrderDetailConstraint: NSLayoutConstraint!
    @IBOutlet weak var orderDetailHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var debugButton: UIButton!
    @IBOutlet weak var bottomCompleteButtonConstraint: NSLayoutConstraint!
    @IBOutlet weak var completeButtonHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.presenter = PickupPresenter(delegate: self)
        self.mapView.isMyLocationEnabled = true
        self.bottomOrderDetailConstraint.constant = self.orderDetailHeightConstraint.constant
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter.start()
    }
    
    @IBAction func acceptOrder() {
        self.presenter.acceptOrder()
        self.hideOrder {
            self.showCompleteButton()
        }
    }
    
    @IBAction func declineOrder() {
        self.presenter.declineOrder()
        self.mapView.clear()
        self.hideOrder()
    }
    
    @IBAction func completeOrder() {
        self.hideCompleteButton()
        self.mapView.clear()
    }

    @IBAction func debugTouched() {
        self.presenter.pickUpNewOrder()
    }
}

extension PickupViewController: PickupViewControllerType {

    var map: GMSMapView {
        return self.mapView
    }
    
    func showOrder(_ viewModel: PickupOrderViewModel) {
        self.orderLabel.text = viewModel.orderID
        self.placeLabel.text = viewModel.address
        self.pickupUntilLabel.text = viewModel.pickupUntil
        self.bottomOrderDetailConstraint.constant = 0
        UIView.animate(withDuration: 0.4) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func hideOrder(completion:(() -> Void)? = nil) {
        self.bottomOrderDetailConstraint.constant = self.orderDetailHeightConstraint.constant
        UIView.animate(withDuration: 0.4, animations: {
            self.view.layoutIfNeeded()
        }, completion: { (completed) in
            completion?()
        })
    }
    
    private func showCompleteButton() {
        self.bottomCompleteButtonConstraint.constant = self.completeButtonHeightConstraint.constant
        UIView.animate(withDuration: 0.4) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func hideCompleteButton() {
        self.bottomCompleteButtonConstraint.constant = -self.completeButtonHeightConstraint.constant
        UIView.animate(withDuration: 0.4) {
            self.view.layoutIfNeeded()
        }
    }
    
    func centerMap(location: CLLocation) {
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude,
                                              longitude: location.coordinate.longitude,
                                              zoom: 17.0)
        
        self.mapView.animate(to: camera)
    }
    
    func showPoyline(polyline: GMSPolyline) {
        polyline.map = self.mapView   
    }
}
