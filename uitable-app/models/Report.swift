//
//  Report.swift
//  uitable-app
//
//  Created by Preet G S Anand on 10/12/17.
//  Copyright © 2017 Preet G S Anand. All rights reserved.
//

import Foundation

struct Report {
    private(set) public var title : String
    private(set) public var description  : String
    private(set) public var date : String
    
    init(title : String, description  : String, date : String) {
        self.title = title;
        self.description = description;
        self.date = date;
    }
}
