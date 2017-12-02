import Foundation
import SocketIO
import RealmSwift
import SwiftyJSON


class SocketService {
    static let instance = SocketService()
    let socket : SocketIOClient
    let realm : Realm!
    var completion : socketCompletion!

    
    init() {
        realm = try! Realm()
        let employee = realm.objects(Employee.self)[0]
        socket = SocketIOClient(socketURL : URL(string : BASE_URL)!,
                                config : [.connectParams(["_id" : employee.id,
                                                          "email" : employee.email,
                                                          "designation" : employee.designation,
                                                          "name" : employee.name,
                                                          "gender" : employee.gender])])
        self.initializeListeners()
        socket.connect()
        
        
    }
    
    func setSocketCompletion(completion : @escaping socketCompletion) {
        self.completion = completion
    }
    
    
    func initializeListeners() {
        socket.on("connect") { _, _ in
            print("Socket connected")
            self.completion(ON_USER_CONNECTED)
            self.emitUserOnline()
            self.emitRefreshUserList()
        }
        
        socket.on("onRefreshUserList") { (users, ack) in
            let userListJSON = JSON(users)[0].arrayValue
            self.parseEmployeeList(userList : userListJSON)
            self.completion(ON_REFRESH_USER_LIST)
        }
        
        socket.on("onUserOnline") {(user, ack) in
            print("online : ",user)
            let employeeJSON = JSON(user)[0]
            self.parseEmployee(employeeJSON: employeeJSON)
            self.completion(ON_USER_ONLINE)

        }
        
        socket.on("onUserOffline") {(user, ack) in
            print("offline",user)
            let employeeJSON = JSON(user)[0]
            self.parseEmployee(employeeJSON: employeeJSON)
            self.completion(ON_USER_OFFLINE)
        }
        
        socket.on("onUserConnected") {(user, ack) in
            print("new user",user)
            let employeeJSON = JSON(user)[0]
            self.parseEmployee(employeeJSON: employeeJSON)
            self.completion(ON_USER_CONNECTED)
        }
        
        socket.on("onNewMessage") {(message, ack) in
            print("new message",message)
            let messageJSON = JSON(message)[0]
            self.parseMessage(messageJSON : messageJSON)
            self.completion(ON_NEW_MESSAGE)
        }
        
        socket.on("onNewPost") {(post, ack) in
            print("new post", post)
            let postJSON = JSON(post)[0]
            self.parsePost(postJSON: postJSON)
            print(ON_NEW_POST)
            self.completion(ON_NEW_POST)

        }
        
        socket.on("onPostLiked") { (likeJSON, ack) in
            print("post liked", likeJSON)
            let json = JSON(likeJSON)[0]
            self.parsePostLikeDislike(status: true, json: json)
            self.completion(ON_POST_LIKED)
            
        }
        
        socket.on("onPostDisliked") { (dislikeJSON, ack) in
            print("post disliked", dislikeJSON)
            let json = JSON(dislikeJSON)[0]
            self.parsePostLikeDislike(status: false, json: json)
            self.completion(ON_POST_LIKED)
            
        }
        socket.on("onNewComment") { (commentJSON, ack) in
            print("new comment", commentJSON)
            let json = JSON(commentJSON)[0]
            self.parseNewComment(commentJSON: json)
            print(ON_NEW_COMMENT)
            self.completion(ON_NEW_COMMENT)
            
        }
        
    }
    
    func parseNewComment(commentJSON : JSON) {
        let results = realm.objects(Post.self).filter("id == %@", commentJSON["postId"].stringValue)
        if results.count != 0 {
            let comment = Comment()
            comment.comment = commentJSON["commentText"].stringValue
            comment.id = commentJSON["_id"].stringValue
            comment.user = commentJSON["userId"].stringValue
            
            try! realm.write {
                realm.add(comment)
                if let post = results.first {
                    post.comments = post.comments + "|" + comment.id

                }
            }
        }
    }
    
    
    func parsePostLikeDislike(status : Bool, json : JSON) {
        let results = realm.objects(Post.self).filter("id == %@",json["postId"].stringValue)
        if let post = results.first {
            try! realm.write {
                if status {
                    post.likes = post.likes + "|" + json["userId"].stringValue
                }
                else {
                    let updatedPostLikes = post.likes.replacingOccurrences(of:json["userId"].stringValue, with: "")
                    let filteredLikes = updatedPostLikes.replacingOccurrences(of: "||", with: "|")
                    post.likes = filteredLikes
                }
            }
        }
        else {
            print("Post Like Change : Not found")
        }
    }
    
    
    func parsePost(postJSON : JSON) {
        let results = realm.objects(Post.self).filter("id == %@",postJSON["_id"].stringValue)
        if results.count != 0 {
            if let post = results.first {
                try! realm.write {
                    post.body = postJSON["body"].stringValue
                    post.user = postJSON["user"].stringValue
                    post.date = stringToDate(dateString: postJSON["date"].stringValue)
                    let likesArray = postJSON["likes"].arrayValue
                    post.likes = "";
                    for j in 0..<likesArray.count {
                        if j == 0 {
                            post.likes = likesArray[j].stringValue
                        }
                        else {
                            post.likes = post.likes + "|" + likesArray[j].stringValue
                        }
                    }
                    
                    post.comments = ""
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
                }
            }
            
        }
        else {
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
    func parsePostList(dataJSON : [JSON], completion : @escaping resultCodeCompletion) {
        try! realm.write {
            realm.delete(realm.objects(Post.self))
        }
        
        for i in 0..<dataJSON.count {
            let postJSON = dataJSON[i]
            parsePost(postJSON: postJSON)
        }
    }
    
    func parseEmployeeList(userList : [JSON]) {
        if userList.count != 0 {
            for i in 0..<userList.count {
                let employeeJSON = userList[i]
                print("Saving",employeeJSON)
                parseEmployee(employeeJSON: employeeJSON)
                
                
            }
        }
        
    }
    
    
    func parseEmployee(employeeJSON : JSON) {
        print(employeeJSON);
            let result = realm.objects(Employee.self).filter("id == %@",employeeJSON["_id"].stringValue)
            if result.count != 0 {
                if let employee = result.first {
                    try? self.realm.write {
                        print("--Editing Employee--")
                        employee.email = employeeJSON["email"].stringValue
                        employee.name = employeeJSON["name"].stringValue
                        employee.gender = employeeJSON["gender"].stringValue
                        employee.designation = employeeJSON["designation"].stringValue
                        employee.status = employeeJSON["status"].boolValue
                    }
                }
            }
            else {
                print("--New Employee--")
                
                let employee = Employee()
                    employee.id = employeeJSON["_id"].stringValue
                    employee.email = employeeJSON["email"].stringValue
                    employee.name = employeeJSON["name"].stringValue
                    employee.gender = employeeJSON["gender"].stringValue
                    employee.designation = employeeJSON["designation"].stringValue
                    employee.status = employeeJSON["status"].boolValue
                    
                    
                    try? realm.write {
                        realm.add(employee)
                    }
                
            }
        
    }
    
    func parseMessage(messageJSON : JSON) {
        let message = Message()
        message.from = messageJSON["from"].stringValue
        message.to = messageJSON["to"].stringValue
        message.body = messageJSON["body"].stringValue
        
        try! realm.write {
            realm.add(message)
        }
    }
    
    
    func connect() {
        socket.connect()
        print("Connecting")
        socket.on("connect") { _, _ in
            print("Socket connected")
            self.completion(ON_USER_CONNECTED)
            self.initializeListeners()
            self.emitRefreshUserList()
        }
        
        
    }
    
    func disconnect() {
        socket.disconnect()
    }
    
    func emitRefreshUserList() {
        print("Emiting onRefreshUserList")
        socket.emit("onRefreshUserList")
    }
    
    func emitUserOnline() {
        print("Emiting User Online")
        socket.emit("onUserOnline")
    }
    
    func emitUserOffline() {
        print("Emiting User Offline")
        socket.emit("onUserOffline")
    }
    
    func emitNewMessage(to : String, message : Message) {
        print(message)
        var messageJSON = JSON()
        messageJSON["from"].stringValue = message.from
        messageJSON["to"].stringValue = message.to
        messageJSON["body"].stringValue = message.body
        if let messageString = messageJSON.rawString() {
            print(messageString)
            socket.emit("onNewMessage", messageString)

        }
    }
    
    func emitNewPost(post : Post) {
        print("Emiting post",post)
        var postJSON = JSON()
        postJSON["body"].stringValue = post.body
        postJSON["user"].stringValue = post.user
        if let postString = postJSON.rawString() {
            socket.emit("onNewPost", postString)
        }
    }
    
    func emitPostLiked(postId : String, userId : String) {
        print("Emiting post liked",postId,userId)
        var likeJSON = JSON()
        likeJSON["postId"].stringValue = postId
        likeJSON["userId"].stringValue = userId
        if let likeString = likeJSON.rawString() {
            print("Like String",likeString)
            socket.emit("onPostLiked",likeString)
        }
    }
    
    func emitPostDisliked(postId : String, userId : String) {
        print("Emiting post disliked",postId,userId)
        var dislikeJSON = JSON()
        dislikeJSON["postId"].stringValue = postId
        dislikeJSON["userId"].stringValue = userId
        if let dislikeString = dislikeJSON.rawString() {
            socket.emit("onPostDisliked",dislikeString)
        }
    }
    
    func emitNewComment(postId : String, commentText : String, userId : String) {
        print("Emiting new comment")
        var commentJSON = JSON()
        commentJSON["postId"].stringValue = postId
        commentJSON["commentText"].stringValue = commentText
        commentJSON["userId"].stringValue = userId
        if let commentString = commentJSON.rawString() {
            socket.emit("onNewComment", commentString)
        }
    }
    
    
    
}
