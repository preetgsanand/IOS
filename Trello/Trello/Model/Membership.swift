//
//  Member.swift
//  Trello
//
//  Created by Preet G S Anand on 11/3/17.
//  Copyright © 2017 Preet G S Anand. All rights reserved.
//

import Foundation

class Membership {
    var id : String
    var idMember : String
    var memberType : String
    var unconfirmed : Bool
    var deactivated : Bool
    
    init(id : String, idMember : String, memberType : String, unconfirmed : Bool, deactivated : Bool)
    {
        self.id = id
        self.idMember = idMember
        self.memberType = memberType
        self.unconfirmed = unconfirmed
        self.deactivated = deactivated
    }
    
}
