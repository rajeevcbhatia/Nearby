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
    
    func testPinsLoaded() {
        app.launchArguments = [happyFlowParameter]
        app.launch()
        
    }

}
