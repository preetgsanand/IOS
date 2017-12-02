import Foundation

class EpisodeViewModel {
    var id : Int
    var name : String
    var overview : String
    var still_path : String
    var vote_average : Float
    var air_date : Date
    var episode_number : Int
    
    init(id : Int,
         name : String,
         overview : String,
         still_path : String,
         vote_average : Float,
         air_date : Date,
         episode_number : Int) {
        self.id = id
        self.name = name
        self.overview = overview
        self.still_path = still_path
        self.vote_average = vote_average
        self.air_date = air_date
        self.episode_number = episode_number
    }
    
    func getDate() -> String {
        return DateUtils.dateToReadableFormat(date: air_date)
    }
    
    func getStillUrl() -> URL? {
        return URL(string : MEDIA_BASE_URL + still_path)
    }
}
