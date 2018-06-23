//
//  PickupRepository.swift
//  DefaultProject
//
//  Created by Geraldo Fernandes on 23/06/18.
//  Copyright © 2018 Geraldo Fernandes. All rights reserved.
//

import Foundation
import CoreLocation

protocol PickupRepositoryType {
    func startMonitoringOrder(_ completion: (_ result: PickupOrder) -> Void)
    func stopMonitoringOrder()
    func acceptOrder(id: String)
    func declineOrder(id: String)
}

struct PickupRepository: PickupRepositoryType {
    func startMonitoringOrder(_ completion: (_ result: PickupOrder) -> Void) {
        let pickupOrder = PickupOrder(id: "02194820",
                                      consumerName: "Gerald",
                                      location: CLLocation(latitude: -23.5986555, longitude: -46.6907027),
                                      totalAmount: 1,
                                      change: 1)
        
        completion(pickupOrder)
    }
    
    func stopMonitoringOrder() {
        
    }
    
    func acceptOrder(id: String) {
    }
    
    func declineOrder(id: String) {
    }
}
