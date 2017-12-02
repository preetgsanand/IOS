import Foundation
import RealmSwift


class BoardViewPresenter : GenericViewPresenter {
    
    var realm : Realm
    var boardViewDelegate : BoardViewDelegate!
    var boardListViewModel : BoardListViewModel!
    
    init() {
        realm = try! Realm()
    }
    
    
    func checkInitialSetup() {
        let results = realm.objects(User.self)
        if let me = results.first {
            callBoardListApi(id : me.id)
        }
        else {
            boardViewDelegate.callLoginController()
        }
    }
    
    
    func callBoardListApi(id : String) {
        ApiService.instance.callMemberBoardApi(id: id, API_KEY: API_KEY, TOKEN: ACCESS_TOKEN) { (success, boards) in
            if success , let boardList = boards{
                self.boardListViewModel = BoardListViewModel(boardList : boardList)
                self.boardViewDelegate.renderBoardList(boardListViewModel: self.boardListViewModel)
            }
        }
    }
    
    
    
    func viewDidLoad() {
        
    }
    
    func viewDidAppear() {
        
    }
    
    func viewDidDisappear() {
        
    }
    
    
}
