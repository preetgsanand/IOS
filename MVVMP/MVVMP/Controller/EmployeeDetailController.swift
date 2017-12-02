//
//  EmployeeDetailController.swift
//  MVVMP
//
//  Created by Preet G S Anand on 11/6/17.
//  Copyright © 2017 Preet G S Anand. All rights reserved.
//

import UIKit

class EmployeeDetailController: UIViewController, EmployeeDetailDelegate {


    @IBOutlet weak var name : UILabel!
    @IBOutlet weak var designation : UILabel!
    @IBOutlet weak var address : UILabel!
    @IBOutlet weak var phone : UILabel!
    @IBOutlet weak var gender : UILabel!
    
    var employeeDetailPresenter : EmployeeDetailPresenter!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        employeeDetailPresenter.view = self
        employeeDetailPresenter.viewDidLoad()
    }

    
    func renderView(_ employee: Employee) {
        name?.text = employee.name
        designation?.text = "Designation : "+employee.designation
        address?.text = "Address : "+employee.address
        phone?.text = "Phone : "+employee.phone
        gender?.text = "Gender : "+employee.gender
        
    }
    

}
