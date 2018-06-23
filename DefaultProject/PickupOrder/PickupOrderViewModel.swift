//
//  PickupOrderViewModel.swift
//  DefaultProject
//
//  Created by Geraldo Fernandes on 23/06/18.
//  Copyright © 2018 Geraldo Fernandes. All rights reserved.
//

import Foundation

struct PickupOrderViewModel {
    let orderID: String
    let address: String
    let pickupUntil: String
    
    init(id: String, address: String) {
        let calendar = Calendar.current
        let date = calendar.date(byAdding: .minute, value: 10, to: Date()) ?? Date()
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "HH:mm"
        
        self.pickupUntil = "Pickup until: \(dateFormatterGet.string(from: date))"
        self.orderID = "Order: \(id)"
        self.address = address
    }
}
