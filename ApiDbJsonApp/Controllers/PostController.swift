//
//  PostController.swift
//  ApiDbJsonApp
//
//  Created by Preet G S Anand on 10/27/17.
//  Copyright © 2017 Preet G S Anand. All rights reserved.
//

import UIKit
import RealmSwift

class PostController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    var realm : Realm!
    var postList : Results<Post>!
    
    @IBOutlet weak var postTextField : UITextField?
    @IBOutlet weak var postButton : UIButton?
    @IBOutlet weak var postCollection : UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeData()
        postCollection?.delegate = self
        postCollection?.dataSource = self
        
    }
    
    
    override
    func viewWillAppear(_ animated: Bool) {
        let results = realm.objects(Employee.self)
        if results.count != 0{
            self.initializeHandler()
            self.reloadData()
        }
    }
    
    @IBAction func sendPressed(_ sender : Any) {
        sendNewPost()
    }
    func sendNewPost() {
        if let postText = postTextField?.text {
            let post = Post()
            post.body = postText
            let results = realm.objects(Employee.self)
            if let me = results.first {
                post.user = me.id
            }

            SocketService.instance.emitNewPost(post: post)
            postTextField?.text = ""
        }
    }
    
    func commentsPressed(postId : String) {
        performSegue(withIdentifier: "PostToCommentsSegue", sender: postId)
    }
    
    func initializeHandler() {
        SocketService.instance.setSocketCompletion { (CODE) in
            print(CODE)

            switch CODE {
            case ON_NEW_POST :
                print("On new post")
                self.reloadData()
                self.scrollToPosition(position : self.postList.count-1)
                break;
            case ON_POST_LIKED:
                print("Post Liked")
                self.reloadData()
                break;
            case ON_POST_DISLIKED:
                print("Post Disliked")
                self.reloadData()
                break;
            case ON_NEW_COMMENT:
                self.reloadData()
                break;
            default:
                print("default")
            }
        }
    }
    

    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let postCol = postCollection {
            let bodyWidth = CGFloat(self.postList[indexPath.row].body.count/3+100)
            return CGSize(width : postCol.frame.width - 4,
                          height : bodyWidth);
        }
        else {
            return CGSize(width : 0,
                          height : 0);
        }
        
    }
    
    func initializeData() {
        realm = try! Realm()
        self.postList = realm?.objects(Post.self)
        let results = realm.objects(Employee.self)
        if results.count != 0 {
            initializeHandler()

        }
    }
    
    func reloadData() {
        self.postList = realm.objects(Post.self)
        if let postCol = postCollection {
            postCol.reloadData()
        }
    }
    
    func scrollToPosition(position : Int) {
        let itemIndex = NSIndexPath(item: position, section: 0)
        if let postCol = postCollection {
             postCol.scrollToItem(at: itemIndex as IndexPath, at: UICollectionViewScrollPosition.bottom, animated: false)
        }
       
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let postList = postList {
            return postList.count
        }
        else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        commentsPressed(postId: self.postList[indexPath.row].id)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let postCell = postCollection?.dequeueReusableCell(withReuseIdentifier: "PostCell", for : indexPath) as? PostCell, let post = postList?[indexPath.row]{
            postCell.updateViews(post: post)
            return postCell
        }
        else {
            return PostCell()
        }
    }
    
    override
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PostToCommentsSegue" {
            if let commentController = segue.destination as? CommentController, let postId = sender as? String{
                print(postId)
                commentController.initializeParameter(postId: postId)
            }
        }
    }
    

}
