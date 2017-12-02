
import Foundation
import Alamofire


enum endPoints {
    
    
    case movieNowPlaying(api_key : String, language : String?, page : Int?, region : String?)
    case moviePopular(api_key : String, language : String?, page : Int?, region : String?)
    case movieTop(api_key : String, language : String?, page : Int?, region : String?)
    case movieUpcoming(api_key : String, language : String?, page : Int?, region : String?)
    
    case movieDetail(api_key : String, movie_id : Int, language : String, append_to_response : String)
    
    case movieSearch(api_key : String, query : String, page : Int)
    case tvSearch(api_key : String, query : String, page : Int)
    
    case tvTop(api_key : String, language : String, page : Int)
    case tvPopular(api_key : String, language : String, page : Int)
    case tvOnAir(api_key : String, language : String, page : Int)
    case tvAiringToday(api_key : String, language : String, page : Int)
    
    case tvDetail(api_key : String , tv_id : String, language : String, append_to_response : String)
    
    case seasonDetails(api_key : String, tv_id : Int, season_number : Int, language : String)

    
    func provideValues() -> (url : String, parameters : Parameters, httpMethod : HTTPMethod, parseCode : Int) {
        switch self {
            
        case .movieNowPlaying(let api_key, let language, let page, let region):
            let url = BASE_URL + MOVIE_NOW_PLAYING_API
            let params = parameters(api_key: api_key, language: language ?? "en-US", page: page ?? 1, region: region ?? "US")
            
            return (url : url, parameters : params, httpMethod : HTTPMethod.get, parseCode : 0)
        case .moviePopular(let api_key, let language, let page, let region) :
            let url = BASE_URL + MOVIE_POPULAR
            let params = parameters(api_key: api_key, language: language ?? "en-US", page: page ?? 1, region: region ?? "US")
            
            return (url : url, parameters : params, httpMethod : HTTPMethod.get, parseCode : 0)
        case .movieTop(let api_key, let language, let page, let region) :
            let url = BASE_URL + MOVIE_TOP_RATED
            let params = parameters(api_key: api_key, language: language ?? "en-US", page: page ?? 1, region: region ?? "US")
            
            return (url : url, parameters : params, httpMethod : HTTPMethod.get, parseCode : 0)
        case .movieUpcoming(let api_key, let language, let page, let region) :
            let url = BASE_URL + MOVIE_UPCOMING
            let params = parameters(api_key: api_key, language: language ?? "en-US", page: page ?? 1, region: region ?? "US")
            
            return (url : url, parameters : params, httpMethod : HTTPMethod.get, parseCode : 0)
            
        case .movieDetail(let api_key, let movie_id, let language, let append):
            let url = BASE_URL + MOVIE_DETAIL_API + String(movie_id)
            let params = parameters(api_key: api_key, language: language, append_to_response: append)
            
            return (url : url, parameters : params, httpMethod : HTTPMethod.get, parseCode : 1)
        case .movieSearch(let api_key, let query, let page) :
            let url = BASE_URL + MOVIE_SEARCH_API
            let params = parameters(api_key: api_key, query: query, page: page)
            return (url : url, parameters : params, httpMethod : HTTPMethod.get, parseCode : 0)
            
        case .tvSearch(let api_key, let query, let page):
            let url = BASE_URL + TV_SEARCH_API
            let params = parameters(api_key: api_key, query: query, page: page)
            return (url : url, parameters : params, httpMethod : HTTPMethod.get, parseCode : 3)
            
        case .tvTop(let api_key, let language,let page):
            let url = BASE_URL + TV_TOP_RATED_API
            let params = parameters(api_key: api_key, language: language, page: page)
            return (url : url, parameters : params, httpMethod : HTTPMethod.get, parseCode : 3)
            
        case .tvPopular(let api_key, let language,let page):
            let url = BASE_URL + TV_POPULAR_API
            let params = parameters(api_key: api_key, language: language, page: page)
            return (url : url, parameters : params, httpMethod : HTTPMethod.get, parseCode : 3)
            
        case .tvOnAir(let api_key, let language,let page):
            let url = BASE_URL + TV_ON_AIR_API
            let params = parameters(api_key: api_key, language: language, page: page)
            return (url : url, parameters : params, httpMethod : HTTPMethod.get, parseCode : 3)
            
        case .tvAiringToday(let api_key, let language,let page):
            let url = BASE_URL + TV_AIRING_TODAY_API
            let params = parameters(api_key: api_key, language: language, page: page)
            return (url : url, parameters : params, httpMethod : HTTPMethod.get, parseCode : 3)
            
        case .tvDetail(let api_key, let tv_id, let language, let append_to_response):
            let url = BASE_URL + TV_DETAIL_API + tv_id
            let params = parameters(api_key: api_key, language: language, append_to_response: append_to_response)
            return (url : url, parameters : params, httpMethod : HTTPMethod.get, parseCode : 4)
            
        case .seasonDetails(let api_key, let tv_id, let season_number, let language):
            let url = BASE_URL + "/tv/" + String(tv_id)  + "/season/" + String(season_number)
            let params = parameters(api_key: api_key, language: language, append_to_response: "")
            return (url : url, parameters : params, httpMethod : HTTPMethod.get, parseCode : 5)
        }
    }
    
    
    private func parameters(api_key : String, query : String, page : Int) -> Parameters {
        let parameters : Parameters = [
            "api_key" : api_key,
            "query" : query,
            "page" : page
        ]
        return parameters
    }
    private func parameters(api_key : String, language : String, page : Int) -> Parameters {
        let parameters : Parameters = [
            "api_key" : api_key,
            "language" : language,
            "page" : page
        ]
        return parameters
    }
    
    private func parameters(api_key : String, language : String, append_to_response : String) -> Parameters {
        let parameters : Parameters = [
            "api_key" : api_key,
            "language" : language,
            "append_to_response" : append_to_response
        ]
        return parameters
    }
    
    
    
    private func parameters(api_key : String, language : String, page : Int, region : String) -> Parameters {
        let parameters : Parameters = [
            "api_key" : api_key,
            "language" : language,
            "page" : page,
            "region" : region
        ]
        return parameters
    }
}
