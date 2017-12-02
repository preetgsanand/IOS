//
//  EmployeeCell.swift
//  MVVMP
//
//  Created by Preet G S Anand on 11/6/17.
//  Copyright © 2017 Preet G S Anand. All rights reserved.
//

import UIKit

class EmployeeCell: UITableViewCell {

    @IBOutlet weak var name : UILabel!
    @IBOutlet weak var desgination : UILabel!
    
    func updateView(employee : Employee) {
        name?.text = employee.name
        desgination?.text = employee.designation
    }
    

}
