//
//  CommentCell.swift
//  ApiDbJsonApp
//
//  Created by Preet G S Anand on 11/1/17.
//  Copyright © 2017 Preet G S Anand. All rights reserved.
//

import UIKit
import RealmSwift


class CommentCell: UICollectionViewCell {
    @IBOutlet weak var user : UILabel!
    @IBOutlet weak var commentText : UILabel!
    @IBOutlet weak var date : UILabel!
    
    var realm : Realm!
    
    func updateViews(comment : Comment) {
        realm = try! Realm()
        let results = realm.objects(Employee.self).filter("id == %@",comment.user)
        if results.count != 0 {
            user?.text = results.first?.name
        }
        commentText?.text = comment.comment
        if dateToReadableDateTime(date: comment.date) == dateToReadableDateTime(date: Date()) {
            date?.text = dateToReadableTime(date: comment.date)
        }
        else {
            date?.text = dateToReadableDateTime(date: comment.date)
        }
    }
}
