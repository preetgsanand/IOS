import Foundation

class DataService {
    static let instance : DataService = DataService()
    
    func fetchUserList(completion : @escaping (_ success : Bool, _ data : [User]) -> ()){
        
        Thread.sleep(forTimeInterval: 1.5)
        
        let users = [User(id : "1",
                     name : "Preet G S Anand",
                     designation : "Application Developer"),
                User(id : "2",
                     name : "Himanshu Sharma",
                     designation : "Application Developer"),
                User(id : "3",
                     name : "Raunak Ladha",
                     designation : "Quality Analyst"),]
        completion(true, users)
    }
    
}
