

import Foundation


class SeasonViewModel {
    var seasonId : Int
    var season_number : Int
    var poster_path : String
    var episode_count : Int
    
    init(seasonId : Int,
         season_number : Int,
        poster_path : String,
        episode_count : Int) {
        self.seasonId = seasonId
        self.season_number = season_number
        self.poster_path = poster_path
        self.episode_count = episode_count
    }
    
    func getDetails() -> String {
        return "Season \(season_number)\n (\(episode_count) episodes)"
    }
    
    func getPosterUrl() -> URL? {
        return URL(string : MEDIA_BASE_URL + poster_path)
    }
}


class SeasonDetailViewModel {
    var seasonId : Int
    var poster_path : String
    var air_date : Date
    var name : String
    
    init(seasonId : Int,poster_path : String,
         air_date : Date,name : String) {
        self.seasonId = seasonId
        self.poster_path = poster_path
        self.air_date = air_date
        self.name = name
    }
    
    
    func getName() -> String {
        return "\(name)(\(DateUtils.dateToReadableYear(date: air_date)))"
    }
    
    func getPosterUrl() -> URL? {
        return URL(string : MEDIA_BASE_URL + poster_path)
    }
}
