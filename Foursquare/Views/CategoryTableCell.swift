//
//  CategoryTableCell.swift
//  Foursquare
//
//  Created by Preet G S Anand on 10/18/17.
//  Copyright © 2017 Preet G S Anand. All rights reserved.
//

import UIKit

class CategoryTableCell: UITableViewCell {


    @IBOutlet weak var categoryIcon : UIImageView?
    @IBOutlet weak var categoryTitle : UILabel?
    
    func updateViews(category : String,position : Int) {
        self.categoryTitle?.text = category
        
        if category.lowercased().contains("food") {
            categoryIcon?.image = UIImage(named:"food")
        }
        else if category.lowercased().contains("outdoor") {
            categoryIcon?.image = UIImage(named:"outdoor")
        }
        else if category.lowercased().contains("nightlife") {
            categoryIcon?.image = UIImage(named:"nightlife")
        }
        else if category.lowercased().contains("fun") {
            categoryIcon?.image = UIImage(named:"fun")
        }
        else if category.lowercased().contains("travel") {
            categoryIcon?.image = UIImage(named:"travel")
        }
        else if category.lowercased().contains("shop") {
            categoryIcon?.image = UIImage(named:"shopping")
        }
        
    }

}
