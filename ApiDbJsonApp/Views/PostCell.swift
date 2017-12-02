import UIKit
import RealmSwift

class PostCell: UICollectionViewCell {
    @IBOutlet weak var user : UILabel?
    @IBOutlet weak var body : UILabel?
    @IBOutlet weak var likeButton : UIButton?
    @IBOutlet weak var likeLabel : UILabel?
    @IBOutlet weak var date : UILabel?
    @IBOutlet weak var comentCount : UILabel!

    
    var post : Post!
    var realm : Realm!
    
    
    func updateViews(post : Post) {
        self.post = post
        realm = try! Realm()
        let results = realm.objects(Employee.self)
        if let userObj = results.filter("id == %@",post.user).first {
            user?.text = userObj.name
        }
        else {
            user?.text = "Unknown User"

        }
        if let me = results.first {
            if post.likes.contains(me.id) {
                likeButton?.setImage(UIImage(named : "liked"), for: .normal)
            }
            else {
                likeButton?.setImage(UIImage(named : "unliked"), for: .normal)
            }
        }
        else {
            likeButton?.setImage(UIImage(named : "unliked"), for: .normal)
        }
        body?.text = post.body
        let likes = post.likes.split(separator: "|").count
        if likes == 1 {
            likeLabel?.text = String(likes) + " like"
        }
        else {
            likeLabel?.text = String(likes) + " likes"
        }
        
        let comments = post.comments.split(separator: "|")
        if comments.count == 1 {
            comentCount.text = String(comments.count) + " comment"
        }
        else {
            comentCount.text = String(comments.count) + " comments"
        }
        date?.text = dateToReadableDateTime(date: post.date)
    }
    
    @IBAction func likePressed(_ sender: Any) {
        let results = realm.objects(Employee.self)
        if let me = results.first, let post = self.post{
            if post.likes.contains(me.id) {
                SocketService.instance.emitPostDisliked(postId: post.id, userId: me.id)
            }
            else {
                SocketService.instance.emitPostLiked(postId: post.id, userId: me.id)
            }
        }
    }
    
    
}
