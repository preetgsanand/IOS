import Foundation
import UIKit

class MainTabController : UITabBarController {
    
    var movieNavigation = MovieNavigation()
    var tvNavigation  = TvNavigation()
    var homeNavigation = HomeNavigation()
    
    override
    func viewDidLoad() {
        let homeController = homeNavigation.createHomeModule()
        let movieListController = movieNavigation.createMovieListModule()
        let movieSearchController = movieNavigation.createMovieSearchModule()
        let tvController = tvNavigation.createTvListModule()
        
        var views = [UIViewController]()
        
        views.append(homeController)
        views.append(movieListController)
        views.append(movieSearchController)
        views.append(tvController)
        
        self.viewControllers = views
        self.selectedIndex = 0
    }
    
    
    
    
}
