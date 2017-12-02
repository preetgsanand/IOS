import UIKit

class BoardTabController: UITabBarController, UITabBarControllerDelegate, BoardTabViewDelegate {

    
    var boardTabViewPresenter : BoardTabViewPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
    func instantiateViewController() {
        if let listViewController = self.navigationController?.viewControllers[0] as? ListViewController{
            print("List controller not null")
            listViewController.initializeParameters(boardId: boardTabViewPresenter.boardId)
        }
    }
    
    

    func intializeParamater(boardTabViewPresenter : BoardTabViewPresenter) {
        self.boardTabViewPresenter = boardTabViewPresenter
        
    }
    
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print(tabBarController.selectedIndex)
    }
    
    func addViewController(_ viewController : UIViewController) {
        self.addChildViewController(viewController)
    }
}
