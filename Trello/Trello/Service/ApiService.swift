import Foundation
import SwiftyJSON
import Alamofire

class ApiService {
    static let instance : ApiService = ApiService()
    
    func callMemberDetailApi(username : String, API_KEY : String, TOKEN : String, completion : @escaping (_ success : Bool, _ user : User?) -> ()) {
        let parameters : Parameters = [
            "key" : API_KEY,
            "token" : TOKEN
        ]
        
        let  url = BASE_URL + MEMBER_API + username
        
        Alamofire.request(url, parameters : parameters).validate().responseString { (response) in
            if response.error != nil {
                print(response.error ?? "Null Error")
                completion(false,nil)
            }
            else {
                if let data = response.data {
                    let dataJSON = JSON(data)
                    let user = ParsingService.instance.parseLoginDetails(json: dataJSON)
                    completion(true, user)
                }
            }
        }
    }
    
    func callMemberBoardApi(id : String, API_KEY : String, TOKEN : String, completion : @escaping (_ success : Bool, _ boards : [Board]?) -> ()) {
        let url = BASE_URL + MEMBER_API + id + MEMBER_BOARD_API;
        
        let parameters : Parameters = [
            "key" : API_KEY,
            "token" : TOKEN
        ]
        
        Alamofire.request(url, parameters : parameters).validate().responseString { (response) in
            if response.error != nil {
                print(response.error ?? "Null Error")
                completion(true, nil)
            }
            else {
                if let data = response.data {
                    let dataJSON = JSON(data)
                    let boards = ParsingService.instance.parseBoardList(boardListJSON: dataJSON.arrayValue)
                    print(boards)
                    completion(true, boards)
                }
            }
        }
    }
}
