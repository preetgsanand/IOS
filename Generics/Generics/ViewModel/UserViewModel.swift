import Foundation

class UserViewModel  {
    
    let name : String
    let designation : String
    
    init(name : String, designation : String) {
        self.name = name
        self.designation = designation
    }
    
    func getCleanName() -> String {
        return name
    }
    
    func getCleanDesignation() -> String {
        return designation
    }
}
