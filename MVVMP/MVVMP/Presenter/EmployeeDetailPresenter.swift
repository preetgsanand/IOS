//
//  EmployeeDetailPresenter.swift
//  MVVMP
//
//  Created by Preet G S Anand on 11/6/17.
//  Copyright © 2017 Preet G S Anand. All rights reserved.
//

import Foundation

class EmployeeDetailPresenter {
    
    var employeeViewModel : EmployeeViewModel
    var view : EmployeeDetailDelegate!
    
    init(employeeViewModel : EmployeeViewModel) {
        self.employeeViewModel = employeeViewModel
    }
    
    func viewDidLoad() {
        retrieveEmployeeDetail(employee: employeeViewModel.employee)
    }
    
    func retrieveEmployeeDetail(employee : Employee) {
        ApiService.instance.getEmployeeDetail(employee: employee) { (success, employee) in
            self.view.renderView(employee)
        }
    }
    
    
}
