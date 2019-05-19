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
    
    func testErrorShown() {
        app.launchArguments = [errorFlowParameter]
        app.launch()
        
        let alert = app.alerts.firstMatch
        
        let exists = NSPredicate(format: "exists == true")
        expectation(for: exists, evaluatedWith: alert, handler: nil)
        
        waitForExpectations(timeout: 5, handler: nil)
        
    }

}
