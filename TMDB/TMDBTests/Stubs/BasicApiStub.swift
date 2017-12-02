import Foundation
@testable import TMDB

class BasicApiStub : BasicApiServiceProtocol {
    
    
    var code : endPoints?
    var presenter : PresenterApiProtocol?
    var publishCode : Int?
    

    func makeRequest() {
        guard let values = code?.provideValues() else {
            self.presenter?.publishApiResponse(false, -1, nil)
            return 
        }
        if let data = returnSeedData(parseCode: values.parseCode) {
            self.presenter?.publishApiResponse(true, publishCode ?? 0, data)
        }
        else {
            self.presenter?.publishApiResponse(false, publishCode ?? 0, nil)
        }
        
    }
    
    func initializeValues(code: endPoints, publishCode: Int, presenter: PresenterApiProtocol) {
        self.code = code
        self.publishCode = publishCode
        self.presenter = presenter
    }
    
    
    func returnSeedData(parseCode : Int) -> Any? {
        switch parseCode {
        case 0:
            return returnMovieList()
        case 1:
            return returnMovieDetail()
//        case 2:
//            return parseCastListJSON(castListJSON: json["results"].arrayValue)
        case 3:
            return returnTvList()
//        case 4:
//            return parseTvDetailJSON(tvJSON: json)
//        case 5:
//            return parseSeasonDetailJSON(seasonDetailJSON: json)
        default:
            return nil
        }
    }
    
    func returnMovieList() -> [Movie] {
        return [Movie(id : 1,
                      title : "String",
                      original_title : "String",
                      vote_count : 1,
                      vote_average : 1.0,
                      popularity : 1.0,
                      poster_path : "String",
                      backdrop_path : "String",
                      adult : true,
                      overview : "String",
                      release_date : Date()),
                Movie(id : 1,
                      title : "String",
                      original_title : "String",
                      vote_count : 1,
                      vote_average : 1.0,
                      popularity : 1.0,
                      poster_path : "String",
                      backdrop_path : "String",
                      adult : true,
                      overview : "String",
                      release_date : Date())]
    }
    
    func returnMovieDetail() -> Movie{
        var movie = Movie(id : 1,
                     title : "String",
                     original_title : "String",
                     vote_count : 1,
                     vote_average : 1.0,
                     popularity : 1.0,
                     poster_path : "String",
                     backdrop_path : "String",
                     adult : true,
                     overview : "String",
                     release_date : Date())
        
        movie.setDetails(genres : [Genre](),
                         budget : 0,
                         homepage : "",
                         production_companies : [Company](),
                         tagline : "",
                         cast : [Credit](),
                         status : "")
        return movie
    }
    
    func returnTvList() -> [Tv] {
        return [Tv(id : 1,
                   original_name : "String",
                   name : "String",
                   vote_average : 1.0,
                   poster_path : "String",
                   backdrop_path : "String",
                   first_release_date : Date())]
    }
}
