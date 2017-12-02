import Foundation
import RealmSwift

class Employee : Object {
    @objc dynamic var name : String = "";
    @objc dynamic var id : String = "";
    @objc dynamic var email : String = "";
    @objc dynamic var password : String = "";
    @objc dynamic var designation : String = "";
    @objc dynamic var gender : String = "";
    @objc dynamic var token : String = "";
    @objc dynamic var status : Bool = false


    override static func primaryKey() -> String? {
        return "id"
    }
}
