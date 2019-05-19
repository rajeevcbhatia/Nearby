//
//  StartViewControllerTests.swift
//  NearbyTests
//
//  Created by Rajeev Bhatia on 18/05/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import Foundation
import XCTest
@testable import Nearby

class MapViewControllerTests: XCTestCase {
    
    var mapVC: MapViewController?
    override func tearDown() {
        super.tearDown()
        mapVC = nil
    }
    
    func testVenuesLoaded() {
        let service = MockSuccessService.shared
        mapVC = MapViewController(service: service)
        guard let mapVC = mapVC, let _ = mapVC.view else {
            XCTFail("startView not loaded")
            return
        }
        
        let expectation = XCTestExpectation(description: "annotations loaded")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            XCTAssertEqual(mapVC.mapView.annotations.count, mapVC.venuesForCurrentRegion.count, "all venues not loaded on map")
        }
        
        _ = XCTWaiter.wait(for: [expectation], timeout: 3.0)
    }
}
