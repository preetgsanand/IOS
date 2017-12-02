//
//  EmployeeCell.swift
//  CoreData1
//
//  Created by Preet G S Anand on 10/16/17.
//  Copyright © 2017 Preet G S Anand. All rights reserved.
//

import UIKit

class EmployeeCell: UITableViewCell {

    @IBOutlet weak var name : UILabel?
    
    func updateViews(employee : User) {
        self.name?.text = employee.name
    }

}
