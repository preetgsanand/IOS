import Foundation

class MovieSearchPresenter : PresenterApiProtocol{
   
    
    
    var view : SearchProtocol
    var movieNavigation : MovieNavigationProtocol
    var tvNavigation : TvNavigationProtocol
    var loader : LoaderProtocol
    var page : Int
    var api : BasicApiServiceProtocol
    
    init(view : SearchProtocol, movieNavigation :MovieNavigationProtocol, tvNavigation : TvNavigationProtocol , loader : LoaderProtocol,
         api : BasicApiServiceProtocol) {
        self.view = view
        self.movieNavigation = movieNavigation
        self.tvNavigation = tvNavigation
        self.loader = loader
        self.page = 0
        self.api = api
    }

    func viewDidLoad() {
        view.initializeParameters()
    }
    
    func callSearchApi(query : String, position : Int, publishCode : Int) {
        loader.showLoading()
        switch position {
        case 0:
            api.initializeValues(code : endPoints.movieSearch(api_key: API_KEY, query: query, page: self.page+1), publishCode: publishCode,presenter : self)
            api.makeRequest()
            break;
        case 1:
            api.initializeValues(code : endPoints.tvSearch(api_key: API_KEY, query: query, page: self.page+1), publishCode: publishCode,presenter : self)
            api.makeRequest()
            break;
        default:
            loader.hideLoading()
        }
        
        
    }
    
    func queryEntered(query : String, position : Int) {
        self.page = 0
        if query.count > 2 {
            callSearchApi(query: query, position: position, publishCode: 0)
        }
        else {
            print("Removing")
            view.removeAll(position : position)
        }
    }
    
    func movieSelected(movieViewModel : MovieViewModel) {
        movieNavigation.presentMovieDetailModule(fromView: view , movieId: movieViewModel.id)
    }
    
    func createMovieViewModels(movies : [Movie]) -> [MovieViewModel] {
        var movieViewModels = [MovieViewModel]()
        for i in 0..<movies.count {
            let movieViewModel = MovieViewModel(id : movies[i].id,
                                                title : movies[i].title,
                                                vote_average : movies[i].vote_average,
                                                poster_url : movies[i].poster_path)
            movieViewModels.append(movieViewModel)
        }
        return movieViewModels
    }
    
    func createTvViewModels(tvs : [Tv]) -> [TvViewModel] {
        var tvViewModels = [TvViewModel]()
        
        for i in 0..<tvs.count {
            let tvViewModel = TvViewModel(id : tvs[i].id,
                                          name : tvs[i].name,
                                          backdrop_path : tvs[i].backdrop_path,
                                          vote_average : tvs[i].vote_average,
                                          first_release_date : tvs[i].first_release_date)
            
            tvViewModels.append(tvViewModel)
        }
        return tvViewModels
    }
    
    

    func loadMoreMovies(query : String, position : Int) {
        callSearchApi(query: query, position: position, publishCode: 1)
        api.makeRequest()
        
    }
    
    func publishApiResponse(_ success: Bool, _ code: Int, _ data: Any?) {
        loader.hideLoading()
        switch code {
        case 0:
            if let movies = data as? [Movie] {
                self.page += 1
                let movieViewModels = self.createMovieViewModels(movies: movies)
                self.view.renderMovieList(movieViewModels: movieViewModels)
            }
            else if let tvs = data as? [Tv] {
                self.page += 1
                let tvViewModels = self.createTvViewModels(tvs: tvs)
                self.view.renderTvList(tvViewModels: tvViewModels)
                
            }
            break;
        case 1:
            if let movies = data as? [Movie] {
                self.page += 1
                let movieViewModels = self.createMovieViewModels(movies: movies)
                self.view.add(movieViewModels: movieViewModels)
            }
            else if let tvs = data as? [Tv] {
                self.page += 1
                let tvViewModels = self.createTvViewModels(tvs: tvs)
                self.view.add(tvViewModel: tvViewModels)
                
            }
            break;
        default:
            print("---- Default Publish Code : Tv Detail Presenter", code)
        }
    }
    
    
    func tvSelected(tvViewModel : TvViewModel) {
        tvNavigation.presentTvDetailModule(fromView: view, tvId: tvViewModel.id)
    }

}
