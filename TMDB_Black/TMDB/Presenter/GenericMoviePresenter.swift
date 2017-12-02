
import Foundation


class GenericMoviePresenter : PresenterApiProtocol {
    
    
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
    
    func initializeEndpoint(endPoint : endPoints, parseCode : Int) {
        api.initializeValues(code: endPoint, publishCode: parseCode, presenter: self)
    }
    
    
    func viewDidLoad() {
        loader.showLoading()
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

    
    func publishApiResponse(_ success: Bool, _ code : Int,_ data: Any?) {
        if success,let movies = data as? [Movie] {
            let movieViewModels = self.createViewModels(movies: movies)
            self.view.renderMovieList(movieViewModels: movieViewModels)
            self.loader.hideLoading()
        }
    }
    
    func movieSelected(movieViewModel : MovieViewModel) {
        navigation.presentMovieDetailModule(fromView: view , movieId: movieViewModel.id)
    }
    
}
