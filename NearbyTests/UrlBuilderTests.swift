//
//  UrlBuilderTests.swift
//  NearbyTests
//
//  Created by Rajeev Bhatia on 21/05/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import XCTest
@testable import Nearby

class UrlBuilderTests: XCTestCase {

    func testSearchUrlGenerated() {
        
        let testLat = 0.0
        let testLong = 0.0
        let generatedUrlString = UrlBuilder.searchVenue(latitude: testLat, longitude: testLong).path
        
        let expectedUrlString = "\(UrlBase.base.rawValue)/\(UrlBase.search)?\(UrlParams.clientId.rawValue)=\(UrlValues.clientId.rawValue)&\(UrlParams.clientSecret.rawValue)=\(UrlValues.clientSecret.rawValue)&\(UrlParams.scenario.rawValue)=\(UrlValues.browse.rawValue)&\(UrlParams.categoryId.rawValue)=\(UrlValues.restaurantCategoryId.rawValue)&\(UrlParams.version.rawValue)=\(UrlValues.version)&\(UrlParams.coordinate.rawValue)=\(testLat),\(testLong)&\(UrlParams.radius.rawValue)=\(UrlValues.radius.rawValue)"
        
        XCTAssertEqual(generatedUrlString, expectedUrlString, "Url builder did not generate correct search Url")
    }

}
