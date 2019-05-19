//
//  NearbyUITests.swift
//  NearbyUITests
//
//  Created by Rajeev Bhatia on 19/05/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import XCTest

class NearbyUITests: XCTestCase {
    
    private let happyFlowParameter = "testHappyFlow"
    private let errorFlowParameter = "testErrorFlow"

    let app = XCUIApplication()
    
    override func setUp() {
        continueAfterFailure = false
    }
    
//    func testSearchAgain() {
//        app.launchArguments = [happyFlowParameter]
//        app.launch()
//        
//        let searchHereButton = app.buttons[Identifier.searchHereButton.rawValue]
//        
//        let map = app.maps.element
//        
//        let start = map.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 0))
//        let finish = map.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 6))
//        start.press(forDuration: 0, thenDragTo: finish)
//        
//        XCTAssertTrue(searchHereButton.isHittable)
//        
//    }

}
