//
//  DataService.swift
//  uitable-app
//
//  Created by Preet G S Anand on 10/11/17.
//  Copyright © 2017 Preet G S Anand. All rights reserved.
//

import Foundation

class DataService {
    static let instance = DataService()
    
    private let categories = [
        Category(title : "Eployees"),
        Category(title:  "Clients")
        
    ];
    
    private let reports = [
        Report(title : "Market Research",
               description:"Market research report description",
               date : "12 Jul, 2017"),
        Report(title : "Market Research",
               description:"Market research report description",
               date : "12 Jul, 2017"),
        Report(title : "Market Research",
               description:"Market research report description",
               date : "12 Jul, 2017"),
        Report(title : "Market Research",
               description:"Market research report description",
               date : "12 Jul, 2017"),
        Report(title : "Market Research",
               description:"Market research report description",
               date : "12 Jul, 2017"),
        Report(title : "Market Research",
               description:"Market research report description",
               date : "12 Jul, 2017"),
        
    ]
    
    func getCategories() -> [Category] {
        return self.categories;
    }
    
    func getReports() -> [Report] {
        return self.reports;
    }
}
