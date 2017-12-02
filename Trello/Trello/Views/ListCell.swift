//
//  ListCell.swift
//  Trello
//
//  Created by Preet G S Anand on 11/3/17.
//  Copyright © 2017 Preet G S Anand. All rights reserved.
//

import UIKit

class ListCell: UICollectionViewCell {
    @IBOutlet weak var name : UILabel!
    
    func updateView(list : List) {
        name?.text = list.name
    }
}
