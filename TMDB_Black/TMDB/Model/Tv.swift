import Foundation


class Tv {
    private(set) var id : Int
    private(set) var original_name : String
    private(set) var name : String
    private(set) var vote_average : Float
    private(set) var poster_path : String
    private(set) var backdrop_path : String
    private(set) var first_release_date : Date

    // Optionals
    
    var overview : String?
    var cast : [Credit]?
    var season : [Season]?
    
    init(id : Int,original_name : String, name : String, vote_average : Float,
         poster_path : String, backdrop_path : String, first_release_date : Date) {
        self.id = id
        self.original_name = original_name
        self.name = name
        self.vote_average = vote_average
        self.poster_path = poster_path
        self.backdrop_path = backdrop_path
        self.first_release_date = first_release_date
    }
    
    
    func setDetails(overview : String,cast : [Credit], season : [Season]) {
        self.cast = cast
        self.season = season
        self.overview = overview
    }
    

}
