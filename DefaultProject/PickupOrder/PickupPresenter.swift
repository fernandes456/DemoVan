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
import Alamofire

protocol PickupViewControllerType: class {
    func showOrder(_ pickupOrder: PickupOrder)
    var map: GMSMapView { get }
}

protocol PickupPresenterType {
    func start()
    func stop()
}

struct PickupPresenter: PickupPresenterType {
    weak var delegate: PickupViewControllerType?
    let repository: PickupRepository
    
    init(delegate: PickupViewControllerType) {
        self.delegate = delegate
        self.repository = PickupRepository()
    }
    
    func start() {
        self.repository.startMonitoringOrder { (pickupOrder) in
            self.delegate?.showOrder(pickupOrder)
            
            self.fetchMapData(destinationLocation: pickupOrder.location)
//            self.getAddress(coordinate: pickupOrder.location, currentAdd: { (address) in
//
//            })
        }
    }
    
    func stop() {
//        self.repository.stopMonitoringOrder()
    }
    
    func getAddress(coordinate: CLLocation, currentAdd : @escaping ( _ address: String) -> Void) {
        
        let geocoder = GMSGeocoder()
        let coordinate = CLLocationCoordinate2DMake(coordinate.coordinate.latitude,
                                                    coordinate.coordinate.longitude)
        
        
        var currentAddress = String()
        
        geocoder.reverseGeocodeCoordinate(coordinate) { response , error in
            if let address = response?.firstResult() {
                let lines = address.lines! as [String] // [gfsf] mudar isso aqui
                
                currentAddress = lines.joined(separator: "\n")
                currentAdd(currentAddress)
                
                print("currentAdd: \(currentAddress)")
            }
        }
    }
    
    /////
    func fetchMapData(destinationLocation: CLLocation) {
        //-23.6040221" lon="-46.6960398
        let originAddressLat = -23.6040221
        let originAddressLng = -46.6960398
        let directionURL = "https://maps.googleapis.com/maps/api/directions/json?" +
            "origin=\(originAddressLat),\(originAddressLng)&destination=\(destinationLocation.coordinate.latitude),\(destinationLocation.coordinate.longitude)&" +
        "key=AIzaSyBnrySnXSIxxLuk_4ctIrVNymp0eDDhQPc"

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
        polyline.map = self.delegate?.map

//        self.fitAllMarkers(_path: path!)
//        self.delegate?.map.animate(with: GMSCameraUpdate.fit(GMSCoordinateBounds(path: polyline.path!), withPadding: 10))
//        var bounds = GMSCoordinateBounds()
//
//        if let path = path {
//            for index in 1...path.count() {
//                bounds = bounds.includingCoordinate(path.coordinate(at: index))
//            }
//
//            self.delegate?.map.animate(with: GMSCameraUpdate.fit(bounds))
//        }
    }
    
    func fitAllMarkers(_path: GMSPath) {
        var bounds = GMSCoordinateBounds()
        for index in 1..._path.count() {
            bounds = bounds.includingCoordinate(_path.coordinate(at: index))
        }
        self.delegate?.map.animate(with: GMSCameraUpdate.fit(bounds))
    }
}
