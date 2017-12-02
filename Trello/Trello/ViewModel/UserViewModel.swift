import Foundation
import RealmSwift

class UserViewModel {
    private(set) var user : User
    private(set) var realm : Realm!
    
    init(user : User) {
        self.user = user
        realm = try! Realm()
    }
    
    
    func getUser() -> User{
        return self.user
    }
    
    
    func createUser() {
        try! realm.write {
            realm.add(self.user)
        }
    }
    
    func editUser(id : String, username : String, fullname : String, email : String) {
        user.id = id
        user.username = username
        user.fullname = fullname
        user.email = email
    }
}
