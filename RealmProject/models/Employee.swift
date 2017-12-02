//
//  Employee.swift
//  RealmProject
//
//  Created by Preet G S Anand on 10/16/17.
//  Copyright © 2017 Preet G S Anand. All rights reserved.
//

import Foundation
import RealmSwift

class Employee : Object {
    @objc dynamic var id : String = "";
    @objc dynamic var name : String = "";
    @objc dynamic var email : String = "";
    @objc dynamic var password : String = "";
    
    override
    static func primaryKey() -> String {
        return "id"
    }
}

