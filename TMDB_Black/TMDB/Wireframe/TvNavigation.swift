
import Foundation
import UIKit

class TvNavigation : TvNavigationProtocol {
    
    var mainStoryBoard : UIStoryboard {
        return UIStoryboard(name : "Main", bundle : Bundle.main)
    }
    
    func createTvListModule() -> UIViewController {
        let viewController = mainStoryBoard.instantiateViewController(withIdentifier: "TvController")
        
        if let tvController = viewController as? TvController {
            
            let presenter = TvPresenter(view : tvController,
                                        navigation : self, loader : tvController,
                                        api : BasicApiService())
            
            tvController.presenter = presenter
            return tvController
        }
        else {
            return UIViewController()
        }
    }
    
    func createTvDetailModule(tvId : Int) -> UIViewController {
        let viewController = mainStoryBoard.instantiateViewController(withIdentifier: "TvDetailController")
        
        if let tvDetailController = viewController as? TvDetailController {
            let presenter = TvDetailPresenter(tv : tvId,
                                              view : tvDetailController,
                                              loader : tvDetailController,
                                              navigation : self,
                                              api : BasicApiService(),
                                              peopleNavigation : PeopleNavigation())
            

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
    
    func createSeasonDetailModule(tvId : Int, seasons : [SeasonViewModel]) -> UIViewController {
        let viewController = mainStoryBoard.instantiateViewController(withIdentifier: "SeasonDetailController")
        
        if let seasonDetailController = viewController as? SeasonDetailController {
            let presenter = SeasonDetailPresenter(tvId : tvId, seasonViewModels : seasons,
                                                  loader : seasonDetailController, view : seasonDetailController,
                                                  api : BasicApiService())
            seasonDetailController.presenter = presenter
            return seasonDetailController
            
        }
        else {
            return UIViewController()
        }
    }
    
    func presentSeasonDetailModule(fromView : Any?, tvId : Int, seasons : [SeasonViewModel]) {
        if let source = fromView as? UIViewController {
            let seasonDetailController = createSeasonDetailModule(tvId: tvId, seasons: seasons)
            source.navigationController?.pushViewController(seasonDetailController, animated: true)
        }
    }
    
    
    
    
}
