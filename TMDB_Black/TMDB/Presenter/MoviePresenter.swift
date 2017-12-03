import Foundation

class MoviePresenter : PresenterApiProtocol{
    
    
    func publishApiResponse(_ success: Bool, _ code : Int,_ data: Any?) {
        loader.hideLoading()
        switch code {
        case 0:
            if success,let movies = data as? [Movie] {
                let movieViewModels = self.createViewModels(movies: movies)
                self.view.renderMovieList(movieViewModels: movieViewModels)
                self.loader.hideLoading()
            }
            break;
        case 1:
            if let movies = data as? [Movie] {
                self.page += 1
                let movieViewModels = self.createViewModels(movies: movies)
                self.view.add(movieViewModels: movieViewModels)
            }
            break;
        default:
            print("--- Default Publish Code : Movie Presenter ---- ", code)
        }
    }
    
    
    var loader : LoaderProtocol
    var view: MovieProtocol
    var navigation : MovieNavigationProtocol
    var page : Int
    var api : BasicApiServiceProtocol
    
    init(loader : LoaderProtocol, view : MovieProtocol, navigation : MovieNavigationProtocol, api : BasicApiServiceProtocol) {
        self.loader = loader
        self.view = view
        self.navigation = navigation
        self.page = 1
        self.api = api
    }
    
    func viewDidLoad() {
        self.view.initializeSegmentControl()
        callMovieApi(position: 0)
    }
    
    func createServiceForSegment(position : Int, page : Int, publishCode : Int) {
        switch position {
        case 0:
            api.initializeValues(code : endPoints.movieNowPlaying(api_key: API_KEY, language: "en-US", page: page, region: "US"), publishCode : publishCode, presenter : self)
        case 1:
            api.initializeValues(code : endPoints.moviePopular(api_key: API_KEY, language: "en-US", page: page, region: "US"), publishCode : publishCode, presenter : self)
        case 2:
            api.initializeValues(code : endPoints.movieTop(api_key: API_KEY, language: "en-US", page: page, region: "US"), publishCode : publishCode, presenter : self)
        case 3:
            api.initializeValues(code : endPoints.movieUpcoming(api_key: API_KEY, language: "en-US", page: page, region: "US"), publishCode : publishCode, presenter : self)
        default:
            api.initializeValues(code : endPoints.movieNowPlaying(api_key: API_KEY, language: "en-US", page: 1, region: "US"), publishCode : publishCode, presenter : self)
        }
    }
    
    
    func setViewTitleForPoisition(position : Int) {
        switch position {
        case 0:
            self.view.changeViewTitle("Now")
        case 1:
            self.view.changeViewTitle("Popular")
        case 2:
            self.view.changeViewTitle("Top")
        case 3:
            self.view.changeViewTitle("Upcoming")
        default:
            self.view.changeViewTitle("Discover")
        }
    }
    
    func callMovieApi(position : Int) {
        loader.showLoading()
        self.page = 1
        setViewTitleForPoisition(position: position)
        createServiceForSegment(position: position, page: self.page, publishCode: 0)
        api.makeRequest()
    }

    
    func createViewModels(movies : [Movie]) -> [MovieViewModel] {
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
    
    
    
    func movieSelected(movieViewModel : MovieViewModel) {
        navigation.presentMovieDetailModule(fromView: view , movieId: movieViewModel.id)
    }
    
    
    func loadMoreMovies(position : Int) {
        setViewTitleForPoisition(position: position)
        createServiceForSegment(position: position, page : page+1, publishCode: 1)
        api.makeRequest()

    }
    


}
