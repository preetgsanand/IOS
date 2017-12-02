import XCTest
@testable import TMDB

class MoviePresenterTests: XCTestCase {
    
    var moviePresenter : MoviePresenter!
    let loader : LoaderMockProtocol = LoaderMock()
    let view : MovieMockProtocol = MovieProtocolMock()
    let navigation : MovieNavigationMockProtocol = MovieNavigationMock()
    let api = BasicApiStub()
    
    override func setUp() {
        
        moviePresenter = MoviePresenter(loader : loader,
                                        view : view,
                                        navigation : navigation,
                                        api : api)
        super.setUp()
        
    }
    
    override func tearDown() {
       
        super.tearDown()
    }
    
    func testViewDidLoad() {
        XCTAssert(loader.getLoading() == false)
        moviePresenter.viewDidLoad()
        XCTAssert(loader.getLoading() == false)
        XCTAssert(view.getViewTitle() == "Now")
        XCTAssert(view.getMovieViewModels().count == 2)
    }
    
    func testCallMovieApi() {
        moviePresenter.callMovieApi(position: 1)
        XCTAssert(view.getViewTitle() == "Popular")

        XCTAssert(view.getMovieViewModels().count == 2)
        XCTAssert(loader.getLoading() == false)
    }
    
    func testPresentMovieDetail() {
        let movieViewModel = MovieViewModel(id : 1,
                                            title : "It",
                                            vote_average : 5.6,
                                            poster_url : "Poster Url")
        moviePresenter.movieSelected(movieViewModel: movieViewModel)
        XCTAssert(navigation.getDetailPresented() == true)
    }

    
    func testLoadMoreMovies() {
        moviePresenter.loadMoreMovies(position: 0)
        XCTAssert(loader.getLoading() == false)
        XCTAssert(view.getMovieViewModels().count == 2)
        XCTAssert(view.getViewTitle() == "Now")
    }
    
    
}
