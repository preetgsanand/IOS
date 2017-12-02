
import Foundation


class HomePresenter : PresenterApiProtocol {
    var homeNavigation : HomeNavigationProtocol
    var movieNavigation : MovieNavigationProtocol
    var tvNavigation : TvNavigationProtocol
    var view : HomeProtocol
    var api : BasicApiServiceProtocol
    var loader : LoaderProtocol
    
    init(homeNavigation : HomeNavigationProtocol, movieNavigation : MovieNavigationProtocol, tvNavigation : TvNavigationProtocol,view : HomeProtocol,
         api : BasicApiServiceProtocol, loader : LoaderProtocol) {
        self.homeNavigation = homeNavigation
        self.movieNavigation = movieNavigation
        self.tvNavigation = tvNavigation
        self.view = view
        self.api = api
        self.loader = loader
    }
    
    
    func viewDidLoad() {
        view.initializeParameters()
        loader.showLoading()
        callGenreListApi()
    }
    
    func callGenreListApi() {
        api.initializeValues(code: .genreMovieList(api_key: API_KEY, language: "en-US"), publishCode: 0, presenter: self)
        api.makeRequest()
    }
    
    func callPopularMoviesApi() {
        api.initializeValues(code: .moviePopular(api_key: API_KEY, language: "en-US", page: 1, region: "US"), publishCode: 1, presenter: self)
        api.makeRequest()
    }
    
    func callPopularTvShowsApi() {
        api.initializeValues(code: .tvPopular(api_key: API_KEY, language: "en-US", page: 1), publishCode: 2, presenter: self)
        api.makeRequest()
    }
    
    func callLatestMoviesApi() {
        api.initializeValues(code: .movieNowPlaying(api_key: API_KEY, language: "en-US", page: 1, region: "US"), publishCode: 3, presenter: self)
        api.makeRequest()
    }
    
    func callLatestTvShowsApi() {
        api.initializeValues(code: .tvAiringToday(api_key: API_KEY, language: "en-US", page: 1), publishCode: 4, presenter: self)
        api.makeRequest()
    }
    
    func createMovieViewModels(movies : [Movie]) -> [MovieViewModel] {
        var movieViewModels = [MovieViewModel]()
        for i in 0..<movies.count {
            let movieViewModel = MovieViewModel(id : movies[i].id,
                                                title : movies[i].title,
                                                vote_average : movies[i].vote_average,
                                                poster_url : movies[i].poster_path,
                                                release_date : movies[i].release_date)
            movieViewModels.append(movieViewModel)
        }
        return movieViewModels
    }
    
    func createGenreViewModels(genres : [Genre]) -> [GenreViewModel] {
        var genreViewModels = [GenreViewModel]()
        
        for i in 0..<genres.count {
            let genreViewModel = GenreViewModel(imageName : genres[i].name.lowercased(),
                                                title : genres[i].name,
                                                id : genres[i].id)
            genreViewModels.append(genreViewModel)
        }
        return genreViewModels
    }
    
    func createTvViewModels(tvs : [Tv]) -> [TvViewModel]{
        var tvViewModels = [TvViewModel]()
        for i in 0..<tvs.count {
            let singleViewModel = TvViewModel(id : tvs[i].id,
                                              name : tvs[i].name,
                                              backdrop_path : tvs[i].backdrop_path,
                                              vote_average : tvs[i].vote_average,
                                              first_release_date : tvs[i].first_release_date)
            tvViewModels.append(singleViewModel)
        }
        return tvViewModels
        
    }
    
    func publishApiResponse(_ success: Bool, _ code: Int, _ data: Any?) {
        loader.hideLoading()
        if success {
            switch code {
            case 0:
                if let genres = data as? [Genre] {
                    let genreViewModels = createGenreViewModels(genres: genres)
                    let listViewModel = ListViewModel(title : "Genres", items : genreViewModels, identifier : "Genre")
                    view.renderListViewModel(listViewModel: listViewModel)
                }
                callPopularMoviesApi()
                break;
            case 1:
                if let movies = data as? [Movie] {
                    let movieViewModels = createMovieViewModels(movies: movies)
                    let listViewModel = ListViewModel(title : "Popular Movies", items : movieViewModels, identifier : "Movie")
                    view.renderListViewModel(listViewModel: listViewModel)
                }
                callPopularTvShowsApi()
                break;
            case 2:
                if let tvs = data as? [Tv] {
                    let tvViewModels = createTvViewModels(tvs: tvs)
                    let listViewModel = ListViewModel(title : "Popular Tv Shows", items : tvViewModels, identifier : "Tv")
                    view.renderListViewModel(listViewModel: listViewModel)
                }
                callLatestMoviesApi()
                break;
            case 3:
                if let movies = data as? [Movie] {
                    let movieViewModels = createMovieViewModels(movies: movies)
                    let listViewModel = ListViewModel(title : "Recent Movies", items : movieViewModels, identifier : "Movie")
                    view.renderListViewModel(listViewModel: listViewModel)
                }
                callLatestTvShowsApi()
                break;
            case 4:
                if let tvs = data as? [Tv] {
                    let tvViewModels = createTvViewModels(tvs: tvs)
                    let listViewModel = ListViewModel(title : "Recent Tv Shows", items : tvViewModels, identifier : "Tv")
                    view.renderListViewModel(listViewModel: listViewModel)
                }
                break;
                
            default :
                print()
            }
        }
    }
    
    
    func genreSelected(genreViewModel : GenreViewModel) {
        homeNavigation.presentGenreMovies(fromView: view, genreId: genreViewModel.id)
    }
    
    
    func movieSelected(movieViewModel : MovieViewModel) {
        movieNavigation.presentMovieDetailModule(fromView: view , movieId: movieViewModel.id)
    }
    
    func tvSelected(tvViewModel : TvViewModel) {
        tvNavigation.presentTvDetailModule(fromView: view, tvId: tvViewModel.id)
    }
    
    
}
