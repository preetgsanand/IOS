import XCTest
@testable import TMDB

class MovieDetailPresenterTests: XCTestCase {
    
    var movieDetailPresenter : MovieDetailPresenter?
    let loader : LoaderMockProtocol = LoaderMock()
    let view : MovieDetailMockProtocol = MovieDetailProtocolMock()
    override func setUp() {
        super.setUp()
        movieDetailPresenter = MovieDetailPresenter(view : view, loader : loader, movieId : 440021,
                                                    api : BasicApiStub())
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testViewDidLoad() {
        
        movieDetailPresenter?.viewDidLoad()
    }
    
    func testCallDetailApi() {
        movieDetailPresenter?.callDetailApi(movieId: 440021)
        XCTAssert(loader.getLoading() == false)
        XCTAssert(view.getViewTitle() == "String")
        XCTAssert(view.getCastViewModel().count == 0)
        XCTAssert(view.getMovieViewModel() != nil)
        
    }
}
