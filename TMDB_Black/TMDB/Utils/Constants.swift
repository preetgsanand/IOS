import Foundation



// Completion Handlers
typealias booleanCompletion = (_ success : Bool) -> ()

typealias booleanMovieDetailCompletion = (_ success : Bool,_ movies : Movie) -> ()
typealias booleanMovieCompletion = (_ success : Bool,_ movies : [Movie]) -> ()
typealias booleanGenreCompletion = (_ success : Bool,_ movies : [Genre]) -> ()

typealias movieViewModelCompletion = (_ movieViewModel : MovieViewModel) -> ()


// API Constants
let API_KEY = "44468543c14f2519f541b18aeaaed065"
let API_READ_ACCESS_TOKEN = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI0NDQ2ODU0M2MxNGYyNTE5ZjU0MWIxOGFlYWFlZDA2NSIsInN1YiI6IjU5ZjZhZjU2OTI1MTQxNDFlZDAyYWE0ZiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.6sR9mRx0TFX65K5vv8bKpZodNy4h3TclLO2VT2ScreM"
let MOVIE_ID = 346364
let PERSON_ID = 1274508
let TV_ID = 1402
let GENRE_ID = 28
let VIDEO_ID = "58f2bf699251413d95006445"
let BASE_URL = "https://api.themoviedb.org/3"
let MEDIA_BASE_URL = "https://image.tmdb.org/t/p/w500"


let MOVIE_NOW_PLAYING_API = "/movie/now_playing"
let MOVIE_POPULAR = "/movie/popular"
let MOVIE_TOP_RATED = "/movie/top_rated"
let MOVIE_UPCOMING = "/movie/upcoming"
//api_key = , language = en-US, page = 1, region = IN,US,EN...

let MOVIE_LATEST = "/movie/latest"
// api_key = , language = en-US


let MOVIE_DETAIL_API = "/movie/"
// /movie/id , api_key, language, append_to_response = credits

let GENRE_MOVIE_LIST_API = "/genre/movie/list"
// api_key , language

let MOVIE_SEARCH_API = "/search/movie"
// api_key, language, query, page, include_adult, region, year

let TV_SEARCH_API = "/search/tv"
// api_key, language, query, page, first_air_date_year

// TV
let TV_TOP_RATED_API = "/tv/top_rated"
let TV_AIRING_TODAY_API = "/tv/airing_today"
let TV_ON_AIR_API = "/tv/on_the_air"
let TV_POPULAR_API = "/tv/popular"

let TV_DETAIL_API = "/tv/"

let PERSON_DETAIL_API = "/person/"
// api_key, person_id, language , append_to_response = movie_credits

