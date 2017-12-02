import XCTest
@testable import TMDB

class ApiTests: XCTestCase {
    
    var service : BasicApiService!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testTvTopApi() {
        let service = BasicApiService(code : endPoints.tvTop(api_key: API_KEY, language: "en-US", page: 1))
        
        let expectation = XCTestExpectation(description : "Wait for api to return")
        
        service.makeRequest { (success, data) in
            XCTAssert(data != nil)
            XCTAssert(data as? [Tv] != nil)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
    }
    
    func testTvPopularApi() {
        let service = BasicApiService(code : endPoints.tvPopular(api_key: API_KEY, language: "en-US", page: 1))
        
        let expectation = XCTestExpectation(description : "Wait for api to return")
        
        service.makeRequest { (success, data) in
            XCTAssert(data != nil)
            XCTAssert(data as? [Tv] != nil)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testTvDetailApi() {
        let service = BasicApiService(code : endPoints.tvDetail(api_key: API_KEY, tv_id : "1402", language: "en-US", append_to_response: "credits"))
        
        let expectation = XCTestExpectation(description : "Wait for api to return")
        
        service.makeRequest { (success, data) in
            XCTAssert(success != false)
            XCTAssert(data != nil)
            XCTAssert(data as? Tv != nil)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
        
    }
    
    
}
