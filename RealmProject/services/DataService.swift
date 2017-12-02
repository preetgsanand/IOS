//
//  DataService.swift
//  RealmProject
//
//  Created by Preet G S Anand on 10/16/17.
//  Copyright © 2017 Preet G S Anand. All rights reserved.
//

import Foundation
class DataService {
    
    static let instance = DataService()
    var employeeList  =  [Employee]()

    func getEmployeeList() ->[Employee] {
        return self.employeeList
    }
    
    
}
