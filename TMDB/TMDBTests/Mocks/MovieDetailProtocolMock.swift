import Foundation
@testable import TMDB


protocol MovieDetailMockProtocol : MovieDetailProtocol {
    func getMovieViewModel() -> MovieDetailViewModel?
    func getCastViewModel() -> [CastViewModel]
    func getViewTitle() -> String
}
class MovieDetailProtocolMock : MovieDetailMockProtocol {
    
 
    
    
    var movieDetailViewModel : MovieDetailViewModel?
    var castViewModels : [CastViewModel]
    var viewTitle : String
    
    init() {
        castViewModels = [CastViewModel]()
        viewTitle = ""
    }
    
    func setTitle(title: String) {
        self.viewTitle = title
    }
    
    func renderView(_ movieDetailViewModel: MovieDetailViewModel, castViewModels: [CastViewModel]) {
        self.movieDetailViewModel = movieDetailViewModel
        self.castViewModels = castViewModels
    }
    
    
    func getMovieViewModel() -> MovieDetailViewModel? {
        guard let viewModel = self.movieDetailViewModel else {
            return nil
        }
        return viewModel
    }
    
    func getCastViewModel() -> [CastViewModel] {
        return self.castViewModels
    }
    
    func getViewTitle() -> String {
        return self.viewTitle
    }
    
    
    
}
