import Foundation

class Employee {
    var id : Int
    var name : String
    var designation : String
    
    var address : String!
    var gender : String!
    var phone : String!
    
    init(id : Int, name : String, designation : String) {
        self.id = id
        self.name = name
        self.designation = designation
    }
}
