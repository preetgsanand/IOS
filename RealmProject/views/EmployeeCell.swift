//
//  EmployeeCell.swift
//  RealmProject
//
//  Created by Preet G S Anand on 10/16/17.
//  Copyright © 2017 Preet G S Anand. All rights reserved.
//

import UIKit

class EmployeeCell: UICollectionViewCell {

    @IBOutlet weak var name : UILabel?
    @IBOutlet weak var email : UILabel?
    
    func updateViews(employee : Employee) {
        name?.text = employee.name
        email?.text = employee.email
    }
}
