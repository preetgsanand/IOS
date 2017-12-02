
import Foundation

class Season {
    var air_date : Date
    var episode_count : Int
    var id : Int
    var poster_path : String
    var season_number : Int
    
    
    init(air_date : Date,
        episode_count : Int,
        id : Int,
        poster_path : String,
        season_number : Int) {
        self.air_date = air_date
        self.episode_count = episode_count
        self.id = id
        self.poster_path = poster_path
        self.season_number = season_number
    }
}

class SeaosonDetail {
    var id : Int
    var air_date : Date
    var name : String
    var overview : String
    var poster_path : String
    var episodes : [Episode]
    
    init(id : Int,
         air_date : Date,
         name : String,
         overview : String,
         poster_path : String,
         episodes : [Episode]) {
        self.id = id
        self.air_date = air_date
        self.name = name
        self.overview = overview
        self.poster_path = poster_path
        self.episodes = episodes
    }
}
