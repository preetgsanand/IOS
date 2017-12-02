//
//  UtilsTests.swift
//  TMDBTests
//
//  Created by Preet G S Anand on 10/31/17.
//  Copyright © 2017 Preet G S Anand. All rights reserved.
//

import XCTest
import Foundation
@testable import TMDB

class UtilsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDateToReadableFormat() {
        let date : Date = Date()
        let dateString =  DateUtils.dateToReadableDateTime(date: date)
        XCTAssertEqual(dateString.count,20)
        //XCTAssertEqual(dateString,"Oct 31, 2017 10:57 AM")
    }
    
    func testDateToReadableTime() {
        let date : Date = Date()
        let timeString = DateUtils.dateToReadableTime(date: date)
        XCTAssertEqual(timeString.count, 7)
        //XCTAssertEqual(timeString, "11:06 AM")
    }
    
}
