//
//  PickupOrder.swift
//  DefaultProject
//
//  Created by Geraldo Fernandes on 23/06/18.
//  Copyright © 2018 Geraldo Fernandes. All rights reserved.
//

import Foundation
import CoreLocation

struct PickupOrder {
    let id: String
    let consumerName: String
    let location: CLLocation
    let totalAmount: Int
    let change: Int
}
