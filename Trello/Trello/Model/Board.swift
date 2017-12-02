import Foundation

class Board {
    var id : String
    var name : String
    var dateLastActivity : Date
    var backgroundImage : String
    var backgroundColor : String!
    
    
    init(id : String, name : String, dateLastActivity : Date, backgroundImage : String, backgroundColor : String?) {
        self.id = id
        self.name = name
        self.dateLastActivity = dateLastActivity
        self.backgroundColor = backgroundColor
        self.backgroundImage = backgroundImage
    }
}
