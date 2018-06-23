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
}

struct PickupPresenter: PickupPresenterType {
    weak var delegate: PickupViewControllerType?
    let repository: PickupRepository
    let locationService: LocationService
    
    init(delegate: PickupViewControllerType) {
        self.delegate = delegate
        self.repository = PickupRepository()
        self.locationService = LocationService()
    }
    
    func start() {
        self.locationService.delegate = self
        self.locationService.start()
        self.repository.startMonitoringOrder { (pickupOrder) in
            self.locationService.fetchMapData(destinationLocation: pickupOrder.location)
            self.locationService.getAddress(coor: pickupOrder.location, currentAdd: { (address) in
                let viewModel = PickupOrderViewModel(id: pickupOrder.id, address: address)
                self.delegate?.showOrder(viewModel)
            })
        }
    }
    
    func stop() {
//        self.repository.stopMonitoringOrder()
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
