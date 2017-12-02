import Foundation
import RealmSwift
import Alamofire
import SwiftyJSON


class ApiService {
    static let instance = ApiService()
    var realm : Realm = try! Realm()
    
    func callLoginApi(email : String, password : String, completion : @escaping resultCodeCompletion) {
        let updateInfo: [String:Any] = [email:"email",
                                        password:"password"]
        
        let url = BASE_URL + LOGIN_API;
        
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                for (key, value) in updateInfo {
                    multipartFormData.append(key.data(using: .utf8)!, withName: value as! String)
                }
            },
            to: url,
            method : .post,
            encodingCompletion : { result in
                
                switch result {
                case .success(let upload, _, _) :
                        upload.responseString(completionHandler: { (response) in
                            if response.response?.statusCode != 200 {
                                if let error = response.data {
                                    let errorJSON = JSON(data : error)
                                    print(errorJSON)
                                    completion(false, errorJSON["meta"]["message"].stringValue)
                                }
                            }
                            else {
                                if let data = response.data {
                                    let dataJSON = JSON(data : data)
                                    print(dataJSON)
                                    if let headers = response.response?.allHeaderFields as? [String : String]{
                                        if let token = headers["x-auth"] {
                                            print("Token : "+String(token));
                                            self.parseLogin(dataJSON: dataJSON,
                                                            token : token,
                                                            completion: completion)
                                        }
                                        else {
                                            completion(false,"No token recieved")
                                            
                                        }
                                        
                                    }
                                    else {
                                        completion(false,"No token recieved")
                                    }
                                }
                            }
                        })
                case .failure(let error) :
                    print(error)
                    completion(false,"Service encountered an error")
                    
                    
                }
            })
    }
    
    
    func callRegisterApi(email : String, password : String, completion : @escaping resultCodeCompletion) {
        let updateInfo: [String:Any] = [email:"email",
                                        password:"password"]
        
        let url = BASE_URL + REGISTER_API;
        
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                for (key, value) in updateInfo {
                    multipartFormData.append(key.data(using: .utf8)!, withName: value as! String)
                }
        },
            to: url,
            method : .post,
            encodingCompletion : { result in
                
                switch result {
                case .success(let upload, _, _) :
                    upload.responseString(completionHandler: { (response) in
                        if response.response?.statusCode != 200 {
                            if let error = response.data {
                                let errorJSON = JSON(data : error)
                                print(errorJSON)
                                completion(false, errorJSON["meta"]["message"].stringValue)
                            }
                        }
                        else {
                            if let data = response.data {
                                let dataJSON = JSON(data : data)
                                print(dataJSON)
                                if let headers = response.response?.allHeaderFields as? [String : String]{
                                    if let token = headers["x-auth"] {
                                        print("Token : "+String(token));
                                        self.parseLogin(dataJSON: dataJSON,
                                                        token : token,
                                                        completion: completion)
                                    }
                                    else {
                                        completion(false,"No token recieved")
                                        
                                    }
                                    
                                }
                                else {
                                    completion(false,"No token recieved")
                                }
                            }
                        }
                    })
                case .failure(let error) :
                    print(error)
                    completion(false,"Service encountered an error")
                    
                    
                }
        })
    }
    
    
    func callEmployeeEditApi(employee : Employee, completion : @escaping resultCodeCompletion) {
        let updateInfo: [String:Any] = [employee.name:"name",
                                        employee.gender:"gender",
                                        employee.designation:"designation"]
        
        let url = BASE_URL + EMPLOYEE_EDIT_API;
        print(employee.token)
        let headers = [
            "x-auth" : employee.token
        ]
        
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                for (key, value) in updateInfo {
                    multipartFormData.append(key.data(using: .utf8)!, withName: value as! String)
                }
        },
            to: url,
            method : .put,
            headers : headers,
            encodingCompletion : { result in
                
                switch result {
                case .success(let upload, _, _) :
                    upload.responseString(completionHandler: { (response) in
                        if response.response?.statusCode != 200 {
                            if let error = response.data {
                                let errorJSON = JSON(data : error)
                                print(errorJSON)
                                completion(false, errorJSON["meta"]["message"].stringValue)
                            }
                        }
                        else {
                            if let data = response.data {
                                let dataJSON = JSON(data : data)
                                print(dataJSON)
                                self.parseEmployee(dataJSON: dataJSON, completion: completion)
                                
                                
                            }
                        }
                    })
                case .failure(let error) :
                    print(error)
                    completion(false,"Service encountered an error")
                    
                    
                }
                
        })

    }

    func callEmployeeListApi(completion : @escaping resultCodeCompletion, token : String) {
        let headers = [
            "x-auth" : token
        ]
        
        Alamofire.request(BASE_URL + EMPLOYEE_LIST_API,
                          headers : headers).validate().responseString { (response) in
            if response.error != nil {
                print(response.error ?? "")
                completion(false,"Service encountered an error")
            }
            else {
                if let data = response.data {
                    let dataJSON = JSON(data)
                    let employeeArray = dataJSON["meta"]["message"].arrayValue
                    self.parseEmployeeList(dataJSON: employeeArray, completion: completion)
                    completion(true,"Success")
                }
            }
        }
    }
    
    
    func callPostListApi(completion : @escaping resultCodeCompletion) {
        Alamofire.request(BASE_URL + POST_LIST_API).validate().responseString { (response) in
            if response.error != nil {
                print(response.error ?? "")
                completion(false,"Service encountered an error")
            }
            else {
                if let data = response.data {
                    let dataJSON = JSON(data)
                    let postArray = dataJSON["meta"]["message"].arrayValue
                    self.parsePostList(dataJSON: postArray, completion: completion)
                    completion(true,"Success")
                }
            }
        }
    }
    
    
    // Parsing
    
    func parsePostList(dataJSON : [JSON], completion : @escaping resultCodeCompletion) {
        try! realm.write {
            realm.delete(realm.objects(Post.self))
            realm.delete(realm.objects(Comment.self))
        }
        
        for i in 0..<dataJSON.count {
            let postJSON = dataJSON[i]
            let post = Post()
            post.body = postJSON["body"].stringValue
            post.user = postJSON["user"].stringValue
            post.id = postJSON["_id"].stringValue
            post.date = stringToDate(dateString: postJSON["date"].stringValue)
            let likesArray = postJSON["likes"].arrayValue
            
            for j in 0..<likesArray.count {
                if j == 0 {
                    post.likes = likesArray[j].stringValue
                }
                else {
                    post.likes = post.likes + "|" + likesArray[j].stringValue
                }
            }
            
            let commentsArray = postJSON["comments"].arrayValue
            
            for j in 0..<commentsArray.count {
                let commentJSON = commentsArray[j]
                let comment = Comment()
                comment.id = commentJSON["_id"].stringValue
                comment.comment = commentJSON["comment"].stringValue
                comment.user = commentJSON["user"].stringValue
                
                try! realm.write {
                    realm.add(comment)
                    print("--Comment--",comment)
                    if j == 0 {
                        post.comments = comment.id;
                    }
                    else {
                        post.comments = post.comments + "|" + comment.id;
                    }
                }
                
            }
            try! realm.write {
                realm.add(post)
                print("--Post--",post)
            }
        }
    }
    
    func parseEmployeeList(dataJSON : [JSON], completion : @escaping resultCodeCompletion) {
        try! realm.write {
            let results = realm.objects(Employee.self)
            realm.delete(results.filter("id != %@",results.first?.id));
        }
        
        for i in 0..<dataJSON.count {
            let employeeJSON = dataJSON[i]
            print("--New employee--",employeeJSON)
            let employee = Employee()
            employee.id = employeeJSON["_id"].stringValue
            employee.email = employeeJSON["email"].stringValue
            employee.name = employeeJSON["name"].stringValue
            employee.gender = employeeJSON["gender"].stringValue
            employee.designation = employeeJSON["designation"].stringValue
            try! realm.write {
                realm.add(employee)
                
            }
            
        }
    }
    
    func parseEmployee(dataJSON : JSON, completion : @escaping resultCodeCompletion) {

        var employee : Employee;
        let employeeList : Results<Employee> = realm.objects(Employee.self).filter("id == %@",
                                                                      String(dataJSON["meta"]["message"]["_id"].stringValue))
        
        
        if employeeList.count != 0 {
            if let employee = employeeList.first {
                try! realm.write {
                    print("--Editing employee--")
                    employee.name = dataJSON["meta"]["message"]["name"].stringValue
                    employee.gender = dataJSON["meta"]["message"]["gender"].stringValue
                    employee.designation = dataJSON["meta"]["message"]["designation"].stringValue
                }
            }
            
        }
        else {
            print("--New employee--")
            employee = Employee()
            employee.id = dataJSON["meta"]["message"]["_id"].stringValue
            employee.email = dataJSON["meta"]["message"]["email"].stringValue
            employee.name = dataJSON["meta"]["message"]["name"].stringValue
            employee.gender = dataJSON["meta"]["message"]["gender"].stringValue
            employee.designation = dataJSON["meta"]["message"]["designation"].stringValue
            try! realm.write {
                realm.add(employee)

            }
        }
        
        completion(true, "Success")
    }
    
    
    func parseLogin(dataJSON : JSON, token : String, completion : @escaping resultCodeCompletion) {

        let employee = Employee()
        employee.id = dataJSON["meta"]["message"]["_id"].stringValue
        employee.email = dataJSON["meta"]["message"]["email"].stringValue
        employee.token = token
        
        try! realm.write {
            realm.add(employee)
            completion(true, "Success")
        }

    }
}
