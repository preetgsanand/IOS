//
//  DataService.swift
//  CoreData1
//
//  Created by Preet G S Anand on 10/16/17.
//  Copyright © 2017 Preet G S Anand. All rights reserved.
//

import Foundation
import CoreData

class DataService {
    
    static let instance  = DataService()
    
    var employeeList = [Employee]();
    
    func getEmployeeList() -> [Employee] {
        return self.employeeList;
    }
    
    func simulateEmployeeApi(appDelegate : AppDelegate) {
        
        employeeList = [Employee(name  : "Preet G S Anand"),
                            Employee(name  : "Prashant Das"),
                            Employee(name  : "Harjot Singh Bhatia")
            ];
        
    }
}
