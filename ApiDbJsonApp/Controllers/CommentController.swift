//
//  CommentController.swift
//  ApiDbJsonApp
//
//  Created by Preet G S Anand on 11/1/17.
//  Copyright © 2017 Preet G S Anand. All rights reserved.
//

import UIKit
import RealmSwift

class CommentController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout{
  
    

    var comments : [Comment] = [Comment]()
    var post : Post!
    var me : Employee!
    @IBOutlet weak var commentCollection : UICollectionView!
    @IBOutlet weak var commentText : UITextField!
    @IBOutlet weak var sendButton : UIButton!
    
    
    var realm : Realm!
    
    override
    func viewDidLoad() {
        commentCollection.delegate = self
        commentCollection.dataSource = self
        
    }
    
    override
    func viewWillAppear(_ animated: Bool) {
            self.initializeHandler()
            self.intializeComments()
    }
    
    
    @IBAction func sendPressed(_ sender : Any) {
        if let me = self.me, let post = self.post, let comment = self.commentText.text {
            SocketService.instance.emitNewComment(postId: post.id, commentText: comment, userId: me.id)
        }
    }
    
    func initializeHandler() {
        SocketService.instance.setSocketCompletion { (CODE) in
            print(CODE)
            switch CODE {
            case ON_NEW_COMMENT :
                print("On new comment")
                self.intializeComments()
                self.commentCollection.reloadData()
                self.scrollToBottom()
                break;
            default:
                print("default")
            }
        }
    }
    
    
    func intializeComments() {
        self.comments.removeAll()
        let commentIds = self.post.comments.split(separator: "|")
        for i in 0..<commentIds.count {
            let results = realm.objects(Comment.self).filter("id == %@", commentIds[i])
            if let comment = results.first{
                comments.append(comment)
            }
        }
    }
    
    
    func scrollToBottom() {
        let lastItemIndex = NSIndexPath(item: self.comments.count-1, section: 0)
        commentCollection.scrollToItem(at: lastItemIndex as IndexPath, at: UICollectionViewScrollPosition.bottom, animated: false)
    }
    
    func initializeParameter(postId : String) {
        self.initializeHandler()
        print(postId)
        realm = try! Realm()
        let results = realm.objects(Post.self).filter("id == %@",postId)
        if let post = results.first {
            self.post = post
        }
        let employees = realm.objects(Employee.self)
        if let me = employees.first {
            self.me = me
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let commentCol = commentCollection {
            let commentHeight = CGFloat(self.comments[indexPath.row].comment.count/4+100)
            return CGSize(width : commentCol.frame.width,
                          height : commentHeight);
        }
        else {
            return CGSize(width : 0,
                          height : 0);
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comments.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let commentCell = commentCollection.dequeueReusableCell(withReuseIdentifier: "CommentCell", for: indexPath) as? CommentCell{
            commentCell.updateViews(comment: comments[indexPath.row])
            return commentCell
        }
        else {
            return CommentCell()
        }
    }
}
