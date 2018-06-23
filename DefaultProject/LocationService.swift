//
//  LocationService.swift
//  DefaultProject
//
//  Created by Geraldo Fernandes on 23/06/18.
//  Copyright © 2018 Geraldo Fernandes. All rights reserved.
//

import Foundation
import CoreLocation
import GoogleMaps
import Alamofire

protocol LocationServiceDelegate {
    func centerMap(location: CLLocation)
    func showPoyline(polyline: GMSPolyline)
}

protocol LocationServiceType: class {
    var delegate: LocationServiceDelegate? {get set}
    func start()
    func getAddress(coor: CLLocation, currentAdd : @escaping ( _ address: String) -> Void)
    func fetchMapData(destinationLocation: CLLocation)
}

class LocationService: NSObject, LocationServiceType {
    var currentLocation: CLLocation?
    var locationManager = CLLocationManager()
    var delegate: LocationServiceDelegate?
    
    func start() {
        self.currentLocation = CLLocation(latitude: -23.6040221, longitude: -46.6960398) // Fake data :-(
        self.locationManager.delegate = self
        self.locationManager.startUpdatingLocation()
    }
    
    func getAddress(coor: CLLocation, currentAdd : @escaping ( _ address: String) -> Void) {
        
        let geocoder = GMSGeocoder()
        let coordinate = CLLocationCoordinate2DMake(coor.coordinate.latitude,
                                                    coor.coordinate.longitude)
        
        geocoder.reverseGeocodeCoordinate(coordinate) { response , error in
            if let address = response?.firstResult(),
                let lines = address.lines
            {
                currentAdd(lines.first ?? "")
            }
        }
    }
    
    func fetchMapData(destinationLocation: CLLocation) {
        guard let currentLocation = self.currentLocation else { return }
        
        let maker = RouterURLMaker()
        let directionURL = maker.getURL(originLocation: currentLocation, destinationLocation: destinationLocation)
        
        
        Alamofire.request(directionURL).responseJSON { response in
            if let JSON = response.result.value {
                
                let mapResponse: [String: AnyObject] = JSON as! [String : AnyObject]
                
                let routesArray = (mapResponse["routes"] as? Array) ?? []
                
                let routes = (routesArray.first as? Dictionary<String, AnyObject>) ?? [:]
                
                let overviewPolyline = (routes["overview_polyline"] as? Dictionary<String,AnyObject>) ?? [:]
                let polypoints = (overviewPolyline["points"] as? String) ?? ""
                let line  = polypoints
                
                self.addPolyLine(encodedString: line)
            }
        }
    }
    
    func addPolyLine(encodedString: String) {
        let path = GMSMutablePath(fromEncodedPath: encodedString)
        let polyline = GMSPolyline(path: path)
        polyline.strokeWidth = 5
        polyline.strokeColor = .blue
        self.delegate?.showPoyline(polyline: polyline)
    }
}

extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        self.currentLocation = locations.last
        
        if let location = self.currentLocation {
            self.delegate?.centerMap(location: location)
        }
        
        self.locationManager.stopUpdatingLocation()
    }
}
