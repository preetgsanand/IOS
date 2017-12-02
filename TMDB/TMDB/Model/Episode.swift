//
//  Episode.swift
//  TMDB
//
//  Created by Preet G S Anand on 11/20/17.
//  Copyright © 2017 Preet G S Anand. All rights reserved.
//

import Foundation

class Episode {
    var id : Int
    var name : String
    var overview : String
    var vote_average : Float
    var still_path : String
    var air_date : Date
    var episode_number : Int
    
    init( id : Int,
        name : String,
        overview : String,
        vote_average : Float,
        still_path : String,
        air_date : Date,
        episode_number : Int) {
        self.id = id
        self.name = name
        self.overview = overview
        self.vote_average = vote_average
        self.still_path = still_path
        self.air_date = air_date
        self.episode_number = episode_number
    }
}
