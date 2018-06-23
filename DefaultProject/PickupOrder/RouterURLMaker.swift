//
//  RouterURLMaker.swift
//  DefaultProject
//
//  Created by Geraldo Fernandes on 23/06/18.
//  Copyright © 2018 Geraldo Fernandes. All rights reserved.
//

import Foundation
import CoreLocation

struct RouterURLMaker {
    func getURL(originLocation: CLLocation, destinationLocation: CLLocation) -> String {
        //-23.6040221" lon="-46.6960398
        let originLat = originLocation.coordinate.latitude
        let originLng = originLocation.coordinate.longitude
        let destinationLat = destinationLocation.coordinate.latitude
        let destinationLng = destinationLocation.coordinate.longitude
        
        let directionURL = "https://maps.googleapis.com/maps/api/directions/json?" +
            "origin=\(originLat),\(originLng)&destination=\(destinationLat),\(destinationLng)&" +
        "key=\(Keys.googleApi)"
        
        return directionURL
    }
}
