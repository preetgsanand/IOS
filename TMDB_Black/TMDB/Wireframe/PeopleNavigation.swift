

import Foundation
import UIKit

class PeopleNavigation : PeopleNavigationProtocol {
    var mainStoryBoard : UIStoryboard {
        return UIStoryboard(name : "Main", bundle : Bundle.main)
    }
    
    func createPeopleDetailModule(peopleId : Int) -> UIViewController{
        let viewController = mainStoryBoard.instantiateViewController(withIdentifier: "PeopleDetailController")
        
        if let peopleDetailController = viewController as? PeopleDetailController {
            let presenter = PeopleDetailPresenter(person : peopleId, view : peopleDetailController, loader : peopleDetailController, navigation : self,
                                                  api : BasicApiService(),
                                                  movieNavigation : MovieNavigation())
            
            peopleDetailController.presenter = presenter
            return peopleDetailController
        }
        else {
            return UIViewController()
        }
    }
    
    func presentPeopleDetail(fromView: Any?, peopleId: Int) {
        if let source = fromView as? UIViewController {
            let peopleDetailController = createPeopleDetailModule(peopleId: peopleId)
            source.navigationController?.pushViewController(peopleDetailController, animated: true)
        }
    }
    
}
