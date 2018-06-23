//
//  PickupPresenter.swift
//  DefaultProject
//
//  Created by Geraldo Fernandes on 23/06/18.
//  Copyright © 2018 Geraldo Fernandes. All rights reserved.
//

import Foundation
import CoreLocation
import GoogleMaps

protocol PickupPresenterType {
    func start()
    func stop()
    func acceptOrder()
    func declineOrder()
    func pickUpNewOrder()
}

class PickupPresenter: PickupPresenterType {
    weak var delegate: PickupViewControllerType?
    let repository: PickupRepositoryType
    let locationService: LocationServiceType
    var currentOrder: PickupOrder?
    
    init(delegate: PickupViewControllerType) {
        self.delegate = delegate
        self.repository = PickupRepository()
        self.locationService = LocationService()
    }
    
    func start() {
        self.locationService.delegate = self
        self.locationService.start()
    }
    
    func stop() {
    }
    
    func acceptOrder() {
        if let id = self.currentOrder?.id {
            self.repository.acceptOrder(id: id)
        }
    }
    
    func declineOrder() {
        if let id = self.currentOrder?.id {
            self.repository.declineOrder(id: id)
        }
    }
    
    func pickUpNewOrder() {
        self.repository.startMonitoringOrder { (pickupOrder) in
            self.currentOrder = pickupOrder
            self.locationService.fetchMapData(destinationLocation: pickupOrder.location)
            self.locationService.getAddress(coor: pickupOrder.location, currentAdd: { (address) in
                let viewModel = PickupOrderViewModel(id: pickupOrder.id, address: address)
                self.delegate?.showOrder(viewModel)
            })
        }
    }
}

extension PickupPresenter: LocationServiceDelegate {
    func centerMap(location: CLLocation) {
        self.delegate?.centerMap(location: location)
    }
    
    func showPoyline(polyline: GMSPolyline) {
        self.delegate?.showPoyline(polyline: polyline)
    }
    
    
}
