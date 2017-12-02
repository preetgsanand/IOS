//
//  CustomCategoryCell.swift
//  uitable-app
//
//  Created by Preet G S Anand on 10/11/17.
//  Copyright © 2017 Preet G S Anand. All rights reserved.
//

import UIKit

class CustomCategoryCell: UITableViewCell {

    @IBOutlet weak var categoryTitle : UILabel!
    
    func updateViews(category : Category) {
        categoryTitle.text = category.title;
    }
}
