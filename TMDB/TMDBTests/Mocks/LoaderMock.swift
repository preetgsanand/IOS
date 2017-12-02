//
//  LoaderMock.swift
//  TMDBTests
//
//  Created by Preet G S Anand on 11/16/17.
//  Copyright © 2017 Preet G S Anand. All rights reserved.
//

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
