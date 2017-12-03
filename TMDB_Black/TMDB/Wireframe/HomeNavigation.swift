import Foundation
import UIKit


class HomeNavigation : HomeNavigationProtocol {
    
    
    var mainStoryBoard : UIStoryboard {
        return UIStoryboard(name : "Main", bundle : Bundle.main)
    }
    
    func createHomeModule() -> UIViewController {
        let viewController = mainStoryBoard.instantiateViewController(withIdentifier: "HomeController")
        
        if let homeController = viewController as? HomeController {
            let presenter = HomePresenter(homeNavigation: self, movieNavigation : MovieNavigation(),
                                          tvNavigation : TvNavigation(),
                                          view: homeController, api: BasicApiService(), loader: homeController)
            homeController.presenter = presenter
            return homeController
        }
        else {
            return UIViewController()
        }
    }
    
    func createGenericMovieListModule(genreId : Int)  -> UIViewController{
        if let genericMovieController = mainStoryBoard.instantiateViewController(withIdentifier: "GenericMovieController") as? GenericMovieController {
            
            let presenter = GenericMoviePresenter(loader : genericMovieController, view : genericMovieController, navigation : MovieNavigation(), api : BasicApiService())
            
            presenter.initializeEndpoint(endPoint: .genreMovies(api_key: API_KEY, genre_id: String(genreId), language: "en-US"), parseCode: 0)
            
            genericMovieController.presenter = presenter
            return genericMovieController
        }
        else {
            return UIViewController()
        }

    }
    
    func presentGenreMovies(fromView: Any?, genreId : Int) {
        if let source = fromView as? UIViewController {
            let genericViewController = createGenericMovieListModule(genreId: genreId)
            source.navigationController?.pushViewController(genericViewController, animated: true)
        }
    }
    
    
    
}
