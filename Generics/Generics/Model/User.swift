//
//  User.swift
//  Generics
//
//  Created by Preet G S Anand on 11/15/17.
//  Copyright © 2017 Preet G S Anand. All rights reserved.
//

import Foundation


class User {
    let id : String
    var name : String
    var designation : String
    
    init(id : String, name : String, designation : String) {
        self.id = id
        self.designation = designation
        self.name = name
    }
    
}
