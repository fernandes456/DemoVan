//
//  DefaultProjectTests.swift
//  DefaultProjectTests
//
//  Created by Geraldo Fernandes on 22/06/18.
//  Copyright © 2018 Geraldo Fernandes. All rights reserved.
//

import XCTest
@testable import DefaultProject
import CoreLocation

class DefaultProjectTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testURLMaker() {
        let maker = RouterURLMaker()
        let originLocation = CLLocation(latitude: -12.34, longitude: -56.78)
        let destinationLocation = CLLocation(latitude: 90.123, longitude: 46.69)
        
        XCTAssertEqual(maker.getURL(originLocation: originLocation, destinationLocation: destinationLocation),
                       "https://maps.googleapis.com/maps/api/directions/json?origin=-12.34,-56.78&destination=90.123,46.69&key=AIzaSyBnrySnXSIxxLuk_4ctIrVNymp0eDDhQPc")
    }
    
}
