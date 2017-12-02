import Foundation
import RealmSwift

class Comment : Object {
    @objc dynamic var id : String = ""
    @objc dynamic var user : String = ""
    @objc dynamic var comment : String = ""
    @objc dynamic var date : Date = Date()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
