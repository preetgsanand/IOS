
import XCTest
@testable import TMDB

class NavigationTests: XCTestCase {
    
    var tvNavigation : TvNavigation!
    var movieNavigation : MovieNavigation!
    
    override func setUp() {
        tvNavigation = TvNavigation()
        movieNavigation = MovieNavigation()
        super.setUp()
        
    }
    
    override func tearDown() {
        
        super.tearDown()
    }
    
    func testCreateMovieListModule() {
        let viewController = movieNavigation.createMovieListModule()
        
        XCTAssert(viewController as? MovieController != nil)
        
        if let movieController = viewController as? MovieController {
            XCTAssert(movieController.moviePresenter as? MoviePresenter != nil)
            if let presenter = movieController.moviePresenter as? MoviePresenter {
                XCTAssert(presenter.loader as? LoaderProtocol != nil)
                XCTAssert(presenter.view as? MovieController != nil)
                XCTAssert(presenter.navigation as? MovieNavigation != nil)
            }
            
        }
    }
    
    
    func testCreateMovieDetailModule() {
        let viewController = movieNavigation.createMovieDetailModule(movieId: 1)
        XCTAssert(viewController as? MovieDetailController != nil)
        if let movieDetailController = viewController as? MovieDetailController {
            XCTAssert(movieDetailController.movieDetailPresenter as? MovieDetailPresenter != nil)
            if let presenter = movieDetailController.movieDetailPresenter as? MovieDetailPresenter {
                XCTAssert(presenter.loader as? LoaderProtocol != nil)
                XCTAssert(presenter.view as? MovieDetailController != nil)
            }
        }
    }
    
    
    func testCreateTvListModule() {
        let viewController = tvNavigation.createTvListModule()
        
        XCTAssert(viewController as? TvController != nil)
        if let tvController = viewController as? TvController {
            XCTAssert(tvController.presenter as? TvPresenter != nil)
            if let presenter = tvController.presenter as? TvPresenter {
                XCTAssert(presenter.loader as? LoaderProtocol != nil)
                XCTAssert(presenter.view as? TvController != nil)
                XCTAssert(presenter.navigation as? TvNavigation != nil)

            }
        }
        
    }
    
}
