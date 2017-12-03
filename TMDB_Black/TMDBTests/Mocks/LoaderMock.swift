import Foundation
@testable import TMDB

protocol LoaderMockProtocol : LoaderProtocol {
    func getLoading() -> Bool
}

class LoaderMock : LoaderMockProtocol {
    var loading : Bool = false
    
    func showLoading() {
        loading = true
    }
    
    func hideLoading() {
        loading = false
        print(" ---- Loading Stopped ---- ")
    }
    
    func getLoading() -> Bool {
        return self.loading
    }
    
    
}
