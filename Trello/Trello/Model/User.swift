import Foundation
import RealmSwift

class User : Object {
    @objc dynamic var id : String = ""
    @objc dynamic var username : String = ""
    @objc dynamic var fullname : String = ""
    @objc dynamic var email : String = ""
    
    convenience init(id : String, username : String, fullname : String, email : String) {
        self.init()
        self.id = id
        self.username = username
        self.fullname = fullname
        self.email = email
    }
}
