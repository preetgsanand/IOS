import Foundation

class MovieDetailPresenter : PresenterApiProtocol {
  
    

    var view : MovieDetailProtocol
    var loader : LoaderProtocol
    var movieId : Int
    var api : BasicApiServiceProtocol
    
    init(view : MovieDetailProtocol, loader : LoaderProtocol, movieId : Int, api : BasicApiServiceProtocol) {
        self.view = view
        self.loader = loader
        self.movieId = movieId
        self.api = api
    }

    func viewDidLoad() {
        loader.showLoading()
        callDetailApi(movieId: movieId)
    }
    
    func returnEndpoint(movieId : Int) -> endPoints {
        return endPoints.movieDetail(api_key: API_KEY, movie_id: movieId, language: "en-US", append_to_response: "credits")
    }
    
    func callDetailApi(movieId : Int) {
        api.initializeValues(code : returnEndpoint(movieId: movieId), publishCode : 0, presenter : self)
        api.makeRequest()
    }
    
    func publishApiResponse(movie : Movie) {
        guard let genre = movie.genres, let cast = movie.cast else {
            return
        }
        let movieDetailViewModel = MovieDetailViewModel(title : movie.title,
                                                        genres : genre,
                                                        vote_average : movie.vote_average,
                                                        poster_path : movie.poster_path,
                                                        overview : movie.overview,
                                                        release_date : movie.release_date)
        var castViewModels = [CastViewModel]()
        for i in 0..<cast.count {
            let castViewModel = CastViewModel(name : cast[i].name,
                                              character : cast[i].character,
                                              profile_path : cast[i].profile_path)
            castViewModels.append(castViewModel)
            
        }
        view.renderView(movieDetailViewModel, castViewModels: castViewModels)
        loader.hideLoading()
        view.setTitle(title: movie.title)
        
    }
    
    func publishApiResponse(_ success: Bool, _ code: Int, _ data: Any?) {
        switch code {
        case 0:
            if let movie = data as? Movie{
                self.publishApiResponse(movie: movie)
            }
            break;
        default:
            print("----- Defualt Publish Code : Movie Detail ----", code)
        }
    }
}
