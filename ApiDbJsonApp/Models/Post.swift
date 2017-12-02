import Foundation
import RealmSwift

class Post : Object {
    @objc dynamic var id : String = "";
    @objc dynamic var body : String =  "";
    @objc dynamic var user : String = "";
    @objc dynamic var date : Date = Date();
    @objc dynamic var likes : String = ""
    @objc dynamic var comments : String = ""
    
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
