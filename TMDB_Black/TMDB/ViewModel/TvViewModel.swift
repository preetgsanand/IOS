import Foundation

class TvViewModel {
    
    var name : String
    var backdrop_path : String
    var vote_average : Float
    var first_release_date : Date
    var id : Int
    
    init(id : Int,name : String, backdrop_path : String, vote_average : Float, first_release_date : Date) {
        self.name = name
        self.backdrop_path = backdrop_path
        self.vote_average = vote_average
        self.first_release_date = first_release_date
        self.id = id
    }
    
    func getTitle() -> String {
        return "\(self.name) (\(DateUtils.dateToReadableYear(date: self.first_release_date)))"
    }
    
    func getBackdropPosterUrl() -> URL? {
        return URL(string : MEDIA_BASE_URL+self.backdrop_path)
    }
}

class TvDetailViewModel {
    var name : String
    var backdrop_path : String
    var vote_average : Float
    var first_release_date : Date
    var overview : String
    
    init( name : String,
        backdrop_path : String,
        vote_average : Float,
        first_release_date : Date,
        overview : String) {
        self.name = name
        self.backdrop_path = backdrop_path
        self.vote_average = vote_average
        self.first_release_date = first_release_date
        self.overview = overview
    }
    
    func getTitle() -> String {
        return "\(self.name) (\(DateUtils.dateToReadableYear(date: self.first_release_date)))"
    }
    
    func getBackdropPosterUrl() -> URL? {
        return URL(string : MEDIA_BASE_URL+self.backdrop_path)
    }
}
