//
//  DetailViewControllerTests.swift
//  NearbyTests
//
//  Created by Rajeev Bhatia on 20/05/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import XCTest
@testable import Nearby

class DetailViewControllerTests: XCTestCase {

    private var detailVC: DetailViewController?
    private var venue: Venue?
    override func setUp() {
        guard let venueData = venueJSON.data(using: String.Encoding.utf8) else {
            XCTFail("could not convert venue string to JSON")
            return
        }
        
        venue = ServiceHelper.decode(data: venueData)
        guard let venue = venue else {
            XCTFail("could not init venue model in detailVC tests")
            return
        }
        
        detailVC = DetailViewController(venue: venue)
    }

    override func tearDown() {
        venue = nil
        detailVC = nil
    }

    func testVenueLoaded() {
        guard let detailVC = detailVC, let _ = detailVC.view else {
            XCTFail("could not init detailVC")
            return
        }
        
        guard let annotation = detailVC.mapView.annotations.first as? MapAnnotation, annotation.title == venue?.name else {
            XCTFail("venue annotation not loaded on detail map")
            return
        }
        
        XCTAssert(detailVC.title == venue?.name, "venue title not loaded on screen")
    }

}

private let venueJSON = """
{
"id": "4c6fc47934443704c2e6215f",
"name": "Waag",
"location": {
    "address": "Aalmarkt 21",
    "lat": 52.159387498982845,
    "lng": 4.490433025085877,
    "labeledLatLngs": [
    {
    "label": "display",
    "lat": 52.159387498982845,
    "lng": 4.490433025085877
    }
    ],
    "distance": 19058,
    "postalCode": "2311 EC",
    "cc": "NL",
    "city": "Leiden",
    "state": "South Holland",
    "country": "Netherlands",
    "formattedAddress": [
    "Aalmarkt 21",
    "2311 EC Leiden",
    "Netherlands"
    ]
},
"categories": [
{
"id": "4bf58dd8d48988d16d941735",
"name": "Café",
"pluralName": "Cafés",
"shortName": "Café",
"icon": {
"prefix": "https://ss3.4sqi.net/img/categories_v2/food/cafe_",
"suffix": ".png"
},
"primary": true
}
],
"referralId": "v-1558387729",
"hasPerk": false
}
"""
