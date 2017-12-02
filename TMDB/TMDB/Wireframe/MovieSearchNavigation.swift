import Foundation
import UIKit

class MovieSearchNavigation : MovieSearchNavigationProtocol {
    
    
    
    
    var mainStoryBoard : UIStoryboard {
        return UIStoryboard(name : "Main", bundle : Bundle.main)
    }
    
    func instantiateMovieNavigationController() -> UIViewController {
        return mainStoryBoard.instantiateViewController(withIdentifier: "MovieNavigationController")
    }
    
    func initializeNavigationController() -> UIViewController {
        let navigationController = instantiateMovieNavigationController()
        
        if let tabController = navigationController.childViewControllers.first as? MainTabController {
            return navigationController
        }
        return UIViewController()
    }
    
    func createMovieListModule() -> UIViewController {
        let viewController = mainStoryBoard.instantiateViewController(withIdentifier: "MovieListController")
        if let movieListController = viewController as? MovieController {
            let presenter = MoviePresenter(loader : movieListController,
                                           view : movieListController,
                                           navigation : self,
                                           api : BasicApiService())
            
            movieListController.moviePresenter = presenter
            return movieListController
        }
        return UIViewController()
    }
    
    
    func createMovieDetailModule(movieId : Int) -> UIViewController {
        let viewController = mainStoryBoard.instantiateViewController(withIdentifier: "MovieDetailController")
        if let movieDetailController = viewController as? MovieDetailController {
            let presenter = MovieDetailPresenter(view : movieDetailController,
                                                 loader : movieDetailController,
                                                 movieId : movieId,
                                                 api : BasicApiService())
            
            
            movieDetailController.movieDetailPresenter = presenter
            return movieDetailController
        }
        return UIViewController()
    }
    
    func createMovieSearchModule() -> UIViewController{
        let viewController = mainStoryBoard.instantiateViewController(withIdentifier: "MovieSearchController")
        if let movieSearchController = viewController as? MovieSearchController {
            let presenter = MovieSearchPresenter(view : movieSearchController,
                                                 navigation : self, loader :
                movieSearchController,
                                                 api : BasicApiService())
            
            
            movieSearchController.movieSearchPresenter = presenter
            return movieSearchController
        }
        return UIViewController()
    }
    
    
    
    func presentMovieDetailModule(fromView : Any?, movieId : Int) {
        let movieDetailController = createMovieDetailModule(movieId: movieId)
        if let source =  fromView as? UIViewController {
            
            source.navigationController?.pushViewController(movieDetailController, animated: true)
        }
    }
    
    func createTvDetailModule(tvId : Int) -> UIViewController {
        let viewController = mainStoryBoard.instantiateViewController(withIdentifier: "TvDetailController")
        
        if let tvDetailController = viewController as? TvDetailController {
            let presenter = TvDetailPresenter(tv : tvId,
                                              view : tvDetailController,
                                              loader : tvDetailController,
                                              navigation : self,
                                              api : BasicApiService())
            
            
            tvDetailController.presenter = presenter
            
            return tvDetailController
        }
        else {
            return UIViewController()
        }
    }
    
    
    func presentTvDetailModule(fromView: Any?, tvId: Int) {
        if let source = fromView as? UIViewController {
            let tvDetailController = createTvDetailModule(tvId : tvId)
            source.navigationController?.pushViewController(tvDetailController, animated: true)
            
        }
    }
}
