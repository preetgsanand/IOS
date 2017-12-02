//
//  List.swift
//  Trello
//
//  Created by Preet G S Anand on 11/3/17.
//  Copyright © 2017 Preet G S Anand. All rights reserved.
//

import Foundation

class List {
    var id : String
    var name : String
    var closed : Bool
    var idBoard : String
    var pos : Int
    var subscribed : Bool
    
    init(id : String, name : String, closed : Bool, idBoard : String, pos : Int, subscribed : Bool) {
        self.id = id
        self.name = name
        self.closed = closed
        self.idBoard = idBoard
        self.pos = pos
        self.subscribed = subscribed
    }
    
}
