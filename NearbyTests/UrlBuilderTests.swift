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
        
        let generatedUrlString = UrlBuilder.searchVenue(latitude: 0, longitude: 0).path
        
        let expectedUrlString = "https://api.foursquare.com/v2/venues/search?client_id=KOGEX4EPMA3OBMOUIJGP22CBCXJVQ1BRLH3W5GLDBB0C2C4L&client_secret=ED3CGJUY1PITOSOBLENAQBJB1TEBD5CGQORLKKOO5WXRLREO&scenario=browse&categoryId=4d4b7105d754a06374d81259&v=\(UrlValues.version)&ll=0.0,0.0&radius=4000"
        
        XCTAssertEqual(generatedUrlString, expectedUrlString, "Url builder did not generate correct search Url")
    }

}
