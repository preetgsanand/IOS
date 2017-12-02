import Foundation


class ApiService {
    static let instance : ApiService = ApiService()
    
    func getEmployeeList(completion : @escaping (_ success : Bool, _ data : [Employee]) -> ()) {
        completion(true, [Employee(id : 1,
                                   name : "Preet G S Anand",
                                   designation : "Developer"),
                          Employee(id : 1,
                                   name : "Raunak Ladha",
                                   designation : "Quality Analyst")])
    }
    
    func getEmployeeDetail(employee : Employee,completion : @escaping (_ success : Bool, _ data : Employee) -> ()) {
        employee.address = "Gurgaon, Haryana - 54"
        employee.gender = "Male"
        employee.phone = "+91 - 78998744426"
        completion(true, employee)
    }
}
