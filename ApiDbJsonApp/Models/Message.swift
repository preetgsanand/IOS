import Foundation
import RealmSwift

class Message : Object {
    @objc dynamic var from : String = "";
    @objc dynamic var to : String = "";
    @objc dynamic var body : String = "";
    @objc dynamic var date : Date = Date();
    @objc dynamic var type : Bool = false;
    // type : false : One to one message
    //type : true : Group message

}

