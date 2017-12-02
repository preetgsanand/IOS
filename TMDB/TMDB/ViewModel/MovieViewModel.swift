import Foundation


class MovieViewModel {
    var id : Int
    var title : String
    var vote_average : Float
    var poster_url : String
    
    init(id : Int,title : String, vote_average : Float, poster_url : String) {
        self.id = id
        self.title = title
        self.vote_average = vote_average
        self.poster_url = poster_url
    }
    
    func getPosterUrl() -> URL? {
        return URL(string : MEDIA_BASE_URL + poster_url)
    }
}


class MovieDetailViewModel {
    var title : String
    var genres : [Genre]
    var vote_average : Float
    var poster_path : String
    var overview : String
    var release_date : Date
    
    init(title : String,
         genres : [Genre],
         vote_average : Float,
         poster_path : String,
         overview : String,
         release_date : Date) {
        self.title = title
        self.genres = genres
        self.vote_average = vote_average
        self.poster_path = poster_path
        self.overview = overview
        self.release_date = release_date
    }


    
    func getGenreString() -> String{
        var genreString = ""
        for i in 0..<genres.count {
            if i == 0 {
                genreString = genres[i].name
            }
            else {
                genreString = " | "+genres[i].name
            }
        }
        return genreString
    }
    
    func getMovieTitle() -> String {
        return title + " (\(DateUtils.dateToReadableYear(date : release_date)))"
    }
    
    func getPosterUrl() -> URL? {
        return URL(string : MEDIA_BASE_URL+poster_path)
    }
    
}
