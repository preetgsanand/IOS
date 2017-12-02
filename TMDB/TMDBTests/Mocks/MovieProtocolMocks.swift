//
//  MovieProtocolMocks.swift
//  TMDBTests
//
//  Created by Preet G S Anand on 11/16/17.
//  Copyright © 2017 Preet G S Anand. All rights reserved.
//

import Foundation
@testable import TMDB


protocol MovieMockProtocol : MovieProtocol {
    func getMovieViewModels() -> [MovieViewModel]
    func getViewTitle() -> String
}

class MovieProtocolMock : MovieMockProtocol {
    var movieViewModels : [MovieViewModel]
    var viewTitle : String
    
    init() {
        movieViewModels = [MovieViewModel]()
        viewTitle = ""
    }
    
    func renderMovieList(movieViewModels: [MovieViewModel]) {
        self.movieViewModels = movieViewModels
    }
    
    func changeViewTitle(_ title: String) {
        self.viewTitle = title
    }
    
    func add(movieViewModels: [MovieViewModel]) {
        self.movieViewModels.append(contentsOf: movieViewModels)
    }
    
    func getViewTitle() -> String {
        return self.viewTitle
    }
    
    func getMovieViewModels() -> [MovieViewModel] {
        return self.movieViewModels
    }
}
