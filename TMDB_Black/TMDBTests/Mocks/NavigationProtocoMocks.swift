import Foundation
import UIKit
@testable import TMDB

protocol MovieNavigationMockProtocol : MovieNavigationProtocol {
    func getDetailPresented() -> Bool
}

class MovieNavigationMock : MovieNavigationMockProtocol{
    
    var detailPresented : Bool = false

    func createMovieListModule() -> UIViewController {
        return MovieController()
    }
    
    func presentMovieDetailModule(fromView: Any?, movieId: Int) {
        self.detailPresented = true
    }
    
    func getDetailPresented() -> Bool {
        return detailPresented
    }
}


protocol TvNavigationMockProtocol : TvNavigationProtocol {
    func getDetailPressed() -> Bool
}
class TvNavigationMock : TvNavigationMockProtocol {
    func presentSeasonDetailModule(fromView: Any?, tvId: Int, seasons: [SeasonViewModel]) {
        
    }
    
    
    var detailPresented : Bool = false

    func createTvListModule() -> UIViewController {
        return TvController()
    }
    
    func presentTvDetailModule(fromView: Any?, tvId: Int) {
        self.detailPresented = true
    }
    
    func getDetailPressed() -> Bool {
        return self.detailPresented
    }
    
    
}
