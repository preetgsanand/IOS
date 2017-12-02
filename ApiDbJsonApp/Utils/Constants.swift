import Foundation

typealias booleanCompletion = (_ success : Bool) -> ()
typealias resultCodeCompletion = (_ success : Bool, _ message : String) -> ()
typealias socketCompletion = (_ code : Int) -> ()


let BASE_URL : String = "http://localhost:8000/"

let LOGIN_API : String = "user/login/"
let REGISTER_API : String = "user/register/"
let EMPLOYEE_EDIT_API : String = "user/"
let POST_LIST_API : String = "post/list/"
let EMPLOYEE_LIST_API : String = "user/list"

//Socket Events
let ON_REFRESH_USER_LIST : Int = 2;
let ON_USER_CONNECTED : Int = 1;
let ON_USER_ONLINE : Int = 3;
let ON_USER_OFFLINE : Int = 4;
let ON_NEW_MESSAGE : Int = 5;
let ON_LOCATION_UPDATE : Int = 6;
let ON_NEW_POST : Int = 7;
let ON_POST_LIKED : Int = 8;
let ON_POST_DISLIKED : Int = 9;
let ON_NEW_COMMENT : Int = 10;
