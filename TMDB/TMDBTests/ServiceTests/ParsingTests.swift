import XCTest
@testable import TMDB


class ParsingTests: XCTestCase {
    
    var basicApiService : BasicApiService!
    override func setUp() {
        basicApiService = BasicApiService(code : endPoints.tvDetail(api_key: API_KEY, tv_id: "1402", language: "en-US", append_to_response: "credits"))
        super.setUp()
        
    }
    
    override func tearDown() {
        super.tearDown()
    }
}
