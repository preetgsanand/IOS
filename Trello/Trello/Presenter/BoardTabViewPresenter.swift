import Foundation
import UIKit

class BoardTabViewPresenter : GenericViewPresenter {
    
    var boardTabViewDelegate : BoardTabViewDelegate!
    var boardId : String
    
    
    init(boardId : String) {
        self.boardId = boardId
    }
    
    
    func viewDidLoad() {
        
    }
    
    func viewDidAppear() {
        
    }
    
    func viewDidDisappear() {
        
    }
    
    func getStoryBoard() -> UIStoryboard{
        return UIStoryboard(name : "Main", bundle : Bundle.main)
    }
    
    func inistantiateViewController() {
        
    }
    
    
}
