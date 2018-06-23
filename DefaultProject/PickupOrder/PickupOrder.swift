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
/*
 [11:59, 6/23/2018] Rodrigo Henriques: data class Order(
 let id: String,
 let consumerName: String,
 let location: LatLng,
 let items: List<OrderItem>,
 let totalAmount: Int,
 let change: Int
 )
 [11:59, 6/23/2018] Rodrigo Henriques: data class LatLng(
 let lat: Double,
 let lng: Double
 )
 [11:59, 6/23/2018] Rodrigo Henriques: data class OrderItem(
 let name: String,
 let quantity: Int,
 let price: Int
 )
 */
