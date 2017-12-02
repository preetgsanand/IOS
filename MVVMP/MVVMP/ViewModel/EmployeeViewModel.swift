//
//  EmployeeListViewModel.swift
//  MVVMP
//
//  Created by Preet G S Anand on 11/6/17.
//  Copyright © 2017 Preet G S Anand. All rights reserved.
//

import Foundation


class EmployeeListViewModel {
    var employeeList : [Employee]
    
    init(employeeList : [Employee]) {
        self.employeeList = employeeList
    }
}

class EmployeeViewModel {
    var employee : Employee
    
    init(employee : Employee) {
        self.employee = employee
    }
}
