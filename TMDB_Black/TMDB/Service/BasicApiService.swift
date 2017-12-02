import Foundation
import Alamofire
import SwiftyJSON


// API

class BasicApiService : BasicApiServiceProtocol {
    var code : endPoints?
    var publishCode : Int?
    var presenter : PresenterApiProtocol?
    

    
    func initializeValues(code : endPoints, publishCode : Int, presenter : PresenterApiProtocol) {
        self.code = code
        self.presenter = presenter
        self.publishCode = publishCode
    }

    
    func makeRequest() {
        guard let request = code?.provideValues() else {
            self.presenter?.publishApiResponse(false, self.publishCode ?? 0, nil)
            return
        }
        
        Alamofire.request(request.url, method: request.httpMethod, parameters: request.parameters).validate().responseString { (response) in
            if response.error != nil {
                self.presenter?.publishApiResponse(false, self.publishCode ?? 0, nil)
            }
            else if let data = response.data {
                if let data = self.designateParsing(code: request.parseCode, json: JSON(data)) {
                    self.presenter?.publishApiResponse(true, self.publishCode ?? 0,data)
                }
                else {
                    self.presenter?.publishApiResponse(false, self.publishCode ?? 0, nil)
                }
            }
            else {
                self.presenter?.publishApiResponse(false, self.publishCode ?? 0, nil)
            }
        }
    }

    
    func designateParsing(code : Int, json : JSON) -> Any? {
        switch code {
        case 0:
            return parseMovieListJSON(movieListJSON: json["results"].arrayValue)
        case 1:
            return parseMovieDetailJSON(movieDetailJSON: json)
        case 2:
            return parseCastListJSON(castListJSON: json["results"].arrayValue)
        case 3:
            return parseTvListJSON(tvListJSON: json["results"].arrayValue)
        case 4:
            return parseTvDetailJSON(tvJSON: json)
        case 5:
            return parseSeasonDetailJSON(seasonDetailJSON: json)
        case 6:
            return parseGenreList(genreListJSON: json["genres"].arrayValue)
        default:
            return nil
        }
    }
    
    func parseMovieListJSON(movieListJSON : [JSON]) -> [Movie] {
        var movies = [Movie]()
        for i in 0..<movieListJSON.count {
            movies.append(parseMovieJSON(movieJSON: movieListJSON[i]))
        }
        return movies
    }
    
    func parseMovieJSON(movieJSON : JSON) -> Movie {

        let date = DateUtils.stringToDate(dateString: movieJSON["release_date"].stringValue)
        let movie = Movie(id : movieJSON["id"].intValue,
                          title : movieJSON["title"].stringValue,
                          original_title : movieJSON["original_title"].stringValue,
                          vote_count : movieJSON["vote_count "].intValue,
                          vote_average : movieJSON["vote_average"].floatValue,
                          popularity : movieJSON["popularity"].floatValue,
                          poster_path : movieJSON["poster_path"].stringValue,
                          backdrop_path : movieJSON["backdrop_path"].stringValue,
                          adult : movieJSON["adult"].boolValue,
                          overview : movieJSON["overview"].stringValue,
                          release_date : date)
        return movie
    }
    
    func parseMovieDetailJSON(movieDetailJSON : JSON) -> Movie {
        
        let date = DateUtils.stringToDate(dateString: movieDetailJSON["release_date"].stringValue)
        
        let movie = Movie(id : movieDetailJSON["id"].intValue,
                          title : movieDetailJSON["title"].stringValue,
                          original_title : movieDetailJSON["original_title"].stringValue,
                          vote_count : movieDetailJSON["vote_count "].intValue,
                          vote_average : movieDetailJSON["vote_average"].floatValue,
                          popularity : movieDetailJSON["popularity"].floatValue,
                          poster_path : movieDetailJSON["poster_path"].stringValue,
                          backdrop_path : movieDetailJSON["backdrop_path"].stringValue,
                          adult : movieDetailJSON["adult"].boolValue,
                          overview : movieDetailJSON["overview"].stringValue,
                          release_date : date,
                          genres : parseGenreList(genreListJSON: movieDetailJSON["genre"].arrayValue),
                          budget: movieDetailJSON["budget"].intValue,
                          homepage: movieDetailJSON["homepage"].stringValue ,
                          production_companies: parseCompanyListJSON(companyListJSON: movieDetailJSON["production_companies"].arrayValue) ,
                          tagline: movieDetailJSON["tagline"].stringValue,
                          cast: parseCastListJSON(castListJSON: movieDetailJSON["credits"]["cast"].arrayValue),
                          status: movieDetailJSON["status"].stringValue)
        
        return movie
    }
    
    
    
    // Company
    
    func parseCompanyListJSON(companyListJSON : [JSON]) -> [Company] {
        var companyList = [Company]()
        
        for i in 0..<companyListJSON.count {
            companyList.append(parseCompanyJSON(companyJSON: companyListJSON[i]))
        }
        return companyList
    }
    
    func parseCompanyJSON(companyJSON : JSON) -> Company {
        return Company(id : companyJSON["id"].intValue,
                       name : companyJSON["name"].stringValue)
    }
    
    
    // Cast
    
    func parseCastListJSON(castListJSON : [JSON]) -> [Credit] {
        var castList = [Credit]()
        
        for i in 0..<castListJSON.count {
            castList.append(parseCastJSON(castJSON: castListJSON[i]))
        }
        return castList
    }
    
    func parseCastJSON(castJSON : JSON) -> Credit {
        return Credit(cast_id : castJSON["cast_id"].intValue,
                      character : castJSON["character"].stringValue,
                      credit_id : castJSON["credit_id"].stringValue,
                      gender : castJSON["gender"].intValue,
                      id : castJSON["id"].intValue,
                      name : castJSON["name"].stringValue,
                      order : castJSON["order"].intValue,
                      profile_path : castJSON["profile_path"].stringValue)
    }
    
    
    // Genre
    
    func parseGenreList(genreListJSON : [JSON]) -> [Genre] {
        var genres = [Genre]()
        for i in 0..<genreListJSON.count {
            genres.append(parseGenre(genreJSON: genreListJSON[i]))
        }
        return genres
    }
    
    func parseGenre(genreJSON : JSON) -> Genre {
        let genre : Genre = Genre(id : genreJSON["id"].intValue,
                                  name : genreJSON["name"].stringValue)
        return genre
    }
    
    //TV
    
    func parseTvListJSON(tvListJSON : [JSON]) -> [Tv] {
        var tvList = [Tv]()
        for i in 0..<tvListJSON.count {
            tvList.append(parseTvJSON(tvJSON: tvListJSON[i]))
        }
        return tvList
    }
    
    func parseTvJSON(tvJSON : JSON) -> Tv {
        let date = DateUtils.stringToDate(dateString: tvJSON["first_air_date"].stringValue)
        return Tv(id : tvJSON["id"].intValue,
                    original_name : tvJSON["original_name"].stringValue,
                    name : tvJSON["name"].stringValue,
                    vote_average : tvJSON["vote_average"].floatValue,
                    poster_path : tvJSON["poster_path"].stringValue,
                    backdrop_path : tvJSON["backdrop_path"].stringValue,
                    first_release_date : date)
        
    }
    
    func parseTvDetailJSON(tvJSON : JSON) -> Tv {

        let date = DateUtils.stringToDate(dateString: tvJSON["first_air_date"].stringValue)


        let tv  = Tv(id : tvJSON["id"].intValue,
                     original_name : tvJSON["original_name"].stringValue,
                     name : tvJSON["name"].stringValue,
                     vote_average : tvJSON["vote_average"].floatValue,
                     poster_path : tvJSON["poster_path"].stringValue,
                     backdrop_path : tvJSON["backdrop_path"].stringValue,
                     first_release_date : date)

        tv.setDetails(overview : tvJSON["overview"].stringValue,
                      cast: parseCastListJSON(castListJSON: tvJSON["credits"]["cast"].arrayValue),
                      season: parseSeasonListJSON(seasonListJSON: tvJSON["seasons"].arrayValue))
        return tv
    }
    
    // Season
    
    func parseSeasonListJSON(seasonListJSON : [JSON]) -> [Season]{
        var seasonList = [Season]()
        
        for i in 0..<seasonListJSON.count {
            seasonList.append(parseSeasonJSON(seasonJSON: seasonListJSON[i]))
        }
        return seasonList
    }
    
    func parseSeasonJSON(seasonJSON : JSON) -> Season{
    
        return Season(air_date : DateUtils.stringToDate(dateString: seasonJSON["air_date"].stringValue),
                      episode_count : seasonJSON["episode_count"].intValue,
                      id : seasonJSON["id"].intValue,
                      poster_path : seasonJSON["poster_path"].stringValue,
                      season_number : seasonJSON["season_number"].intValue)
    }
    
    func parseSeasonDetailJSON(seasonDetailJSON : JSON) -> SeaosonDetail{
        let air_date = DateUtils.stringToDate(dateString: seasonDetailJSON["air_date"].stringValue)
        return SeaosonDetail(id : seasonDetailJSON["id"].intValue,
                             air_date : air_date,
                             name : seasonDetailJSON["name"].stringValue,
                             overview : seasonDetailJSON["overview"].stringValue,
                             poster_path : seasonDetailJSON["poster_path"].stringValue,
                             episodes : parseEpisodeListJSON(episodeListJSON: seasonDetailJSON["episodes"].arrayValue))
    }
    
    
    func parseEpisodeListJSON(episodeListJSON : [JSON]) -> [Episode] {
        var episodeList = [Episode]()
        
        for i in 0..<episodeListJSON.count {
            episodeList.append(parseEpisodeJSON(episodeJSON: episodeListJSON[i]))
        }
        return episodeList
    }
    
    func parseEpisodeJSON(episodeJSON : JSON) -> Episode {
        let air_date = DateUtils.stringToDate(dateString: episodeJSON["air_date"].stringValue)
        return Episode(id : episodeJSON["id"].intValue,
                       name : episodeJSON["name"].stringValue,
                       overview : episodeJSON["overview"].stringValue,
                       vote_average : episodeJSON["vote_average"].floatValue,
                       still_path : episodeJSON["still_path"].stringValue,
                       air_date : air_date,
                       episode_number : episodeJSON["episode_number"].intValue)
    }
    
    
}
