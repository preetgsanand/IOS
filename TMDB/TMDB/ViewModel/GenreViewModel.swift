//
//  GenreViewModel.swift
//  TMDB
//
//  Created by Preet G S Anand on 10/31/17.
//  Copyright © 2017 Preet G S Anand. All rights reserved.
//

import Foundation

class GenreViewModel {
    private(set) var genreList : [Genre]!
    
    init(genres : [Genre]) {
        self.genreList = genres
    }
}
