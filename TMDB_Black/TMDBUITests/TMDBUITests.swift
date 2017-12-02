//
//  TMDBUITests.swift
//  TMDBUITests
//
//  Created by Preet G S Anand on 10/30/17.
//  Copyright © 2017 Preet G S Anand. All rights reserved.
//

import XCTest

class TMDBUITests: XCTestCase {
    
    var app : XCUIApplication!
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app = XCUIApplication()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        app.launch()
        app.buttons["Search"].tap()
        
        let searchfields = app.searchFields
//        app.searchFields["Search"].tap()
//        app.searchFields["Search"].typeText("The")
//
//        Thread.sleep(forTimeInterval: 2)
//        app.swipeUp()
//        app.swipeUp()
//
//        app.buttons["Tv"].tap()
//        Thread.sleep(forTimeInterval: 2)
//        app.swipeUp()
//        app.swipeUp()
        
        
    }
    
}
