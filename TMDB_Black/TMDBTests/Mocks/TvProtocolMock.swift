import Foundation
@testable import TMDB

protocol TvMockProtocol : TvProtocol {
    func getViewModels() -> [TvViewModel]
}
class TvProtocolMock : TvMockProtocol {
    
    
    
    var viewModels : [TvViewModel]
    
    init() {
        self.viewModels = [TvViewModel]()
    }
    
    func renderTvList(viewModels: [TvViewModel]) {
        self.viewModels = viewModels
    }
    
    func add(tvViewModels: [TvViewModel]) {
        self.viewModels.append(contentsOf: tvViewModels)
    }
    
    func getViewModels() -> [TvViewModel] {
        return self.viewModels
    }
    
    
}
