import UIKit
import RealmSwift

class MessageCell: UICollectionViewCell {
    
    @IBOutlet weak var name : UILabel?
    @IBOutlet weak var body : UILabel?
    @IBOutlet weak var date : UILabel?
    
    var realm : Realm!
    

    func updateViews(message : Message) {
        realm = try! Realm()
        if let realm = realm {
            let results = realm.objects(Employee.self).filter("id = %@",message.from)
            if let employee = results.first {
                if let name = name, let body = body, let date = date {
                    name.text = employee.name
                    body.text = message.body
                    if dateToReadableFormat(date: Date()) == dateToReadableFormat(date: message.date) {
                        date.text = dateToReadableTime(date: message.date)
                    }
                    else {
                        date.text = dateToReadableDateTime(date: message.date)

                    }
                }
            }
        }
        
    }
}
