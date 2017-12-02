import UIKit

class ListViewController: UIViewController {

    @IBOutlet weak var listCollection : UICollectionView!
    
    var listViewPresenter : ListViewPresenter!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    func renderData() {
        
    }
    
    func initializeParameters(boardId : String) {
        self.listViewPresenter = ListViewPresenter()
        listViewPresenter.callBoardListApi(boardId: boardId)
    }
    
    


}
