import Foundation
import RealmSwift

class LoginViewPresenter : GenericViewPresenter {

    
    var loginViewDelegate : LoginViewDelegate!
    var realm : Realm!
    
    init() {
        realm = try! Realm()
    }
    
    func validateUsername(username : String) {
        if username.count == 0 {
            loginViewDelegate.publishApiResult(false, "Please enter a valid username")
        }
        else {
            callMemberDetailApi(username: username)
        }
    }
    
    func callMemberDetailApi(username : String) {
        ApiService.instance.callMemberDetailApi(username: username, API_KEY: API_KEY, TOKEN: ACCESS_TOKEN) { (success, user) in
            if success {
                if let user = user {
                    let userViewModel = UserViewModel(user : user)
                    userViewModel.createUser()
                    self.loginViewDelegate.callBoardSegue()
                }
                else {
                    self.loginViewDelegate.publishApiResult(false, "No user returned")
                }
                
            }
            else {
                self.loginViewDelegate.publishApiResult(success, "Invalid Username")
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
