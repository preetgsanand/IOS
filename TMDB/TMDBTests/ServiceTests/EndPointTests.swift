import XCTest
@testable import TMDB

class EndPointTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMovieDetailEndPoints() {
        let service = endPoints.movieDetail(api_key: "api_key", movie_id: 1, language: "en-US", append_to_response: "credits")
        let endPoint = service.provideValues()
        
        XCTAssertEqual(endPoint.url, BASE_URL+MOVIE_DETAIL_API+"1")
        XCTAssertEqual(endPoint.parameters.count, 3)
        XCTAssertEqual(endPoint.parseCode, 1)
    }
    
    func testMoviePopularEndPoint() {
        let service = endPoints.moviePopular(api_key: "api_key", language: "en-US", page: 1, region: "US")
        let endPoint = service.provideValues()
        
        XCTAssertEqual(endPoint.url, BASE_URL+MOVIE_POPULAR)
        XCTAssertEqual(endPoint.parameters.count, 4)
        XCTAssertEqual(endPoint.parseCode, 0)
        
    }
    
    func testMovieSearchEndPoint() {
        let service = endPoints.movieSearch(api_key: "api_key", query: "query", page: 1)
        let endPoint = service.provideValues()
        
        XCTAssertEqual(endPoint.url, BASE_URL+MOVIE_SEARCH_API)
        XCTAssertEqual(endPoint.parameters.count, 3)
        XCTAssertEqual(endPoint.parseCode, 0)
    }
    func testTopTvEndpoint() {
        let service = endPoints.tvTop(api_key: "api_key", language: "en-US", page: 1)
        let endPoint = service.provideValues()
        
        XCTAssertEqual(endPoint.parseCode, 3)
        XCTAssertEqual(endPoint.parameters.count, 3)
        XCTAssertEqual(endPoint.url, BASE_URL+TV_TOP_RATED_API)
    }
    
    func testTvPopularEndpoint() {
        let service = endPoints.tvPopular(api_key : "api_key", language : "en-US", page : 1)
        let endPoint = service.provideValues()
        
        XCTAssertEqual(endPoint.parseCode, 3)
        XCTAssertEqual(endPoint.parameters.count, 3)
        XCTAssertEqual(endPoint.url, BASE_URL+TV_POPULAR_API)
    }
    
    func testTvDetailEndpoint() {
        let service = endPoints.tvDetail(api_key: API_KEY, tv_id: "1402", language: "en-US", append_to_response: "credits")
        
        let endPoint = service.provideValues()
        XCTAssertEqual(endPoint.parseCode, 4)
        XCTAssertEqual(endPoint.parameters.count, 3)
        XCTAssertEqual(endPoint.url, BASE_URL + TV_DETAIL_API + "1402")
        
    }
    
    
}
