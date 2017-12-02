import Foundation

class Movie {
    private(set) var id : Int
    private(set) var title : String
    private(set) var original_title : String
    private(set) var vote_count : Int
    private(set) var vote_average : Float
    private(set) var popularity : Float
    private(set) var poster_path : String
    private(set) var backdrop_path : String
    private(set) var adult : Bool
    private(set) var overview : String
    private(set) var release_date : Date
    
    //optionals
    private(set) var genres : [Genre]?
    private(set) var budget : Int?
    private(set) var homepage : String?
    private(set) var production_companies : [Company]?
    private(set) var tagline : String?
    private(set) var cast : [Credit]?
    private(set) var status : String?
    private(set) var job : String?

    
    init(id : Int,
     title : String,
     original_title : String,
     vote_count : Int,
     vote_average : Float,
     popularity : Float,
     poster_path : String,
     backdrop_path : String,
     adult : Bool,
     overview : String,
     release_date : Date,
     genres : [Genre]? = [Genre](),
     budget : Int? = 0,
     homepage : String? = "",
     production_companies : [Company]? = [Company](),
     tagline : String? = "",
     cast : [Credit]? = [Credit](),
     status : String? = "") {
        self.id = id
        self.title = title
        self.original_title = original_title
        self.vote_count = vote_count
        self.vote_average = vote_average
        self.popularity = popularity
        self.poster_path = poster_path
        self.backdrop_path = backdrop_path
        self.adult = adult
        self.overview = overview
        self.release_date = release_date
        self.genres = genres
        self.budget = budget
        self.homepage = homepage
        self.production_companies = production_companies
        self.tagline = tagline
        self.cast = cast
        self.status = status
        
    }
    
    func setDetails(genres : [Genre],
                    budget : Int,
                    homepage : String,
                    production_companies : [Company],
                    tagline : String,
                    cast : [Credit],
                    status : String) {
        self.genres = genres
        self.budget = budget
        self.homepage = homepage
        self.production_companies = production_companies
        self.tagline = tagline
        self.cast = cast
        self.status = status
    }
    
    func getGenreString() -> String {
        var genreString = ""
        if let genres = self.genres {
            for i in 0..<genres.count {
                if i == 0 {
                    genreString = genres[i].name
                }
                else {
                    genreString = genreString + " | " + genres[i].name
                }
            }
            return genreString
        }
        return ""
        
    }
    
    func setJob(job : String) {
        self.job = job
    }

}
