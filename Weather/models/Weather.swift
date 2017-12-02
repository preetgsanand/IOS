//
//  Weather.swift
//  IOSApiProject
//
//  Created by Preet G S Anand on 10/12/17.
//  Copyright © 2017 Preet G S Anand. All rights reserved.
//

import Foundation

struct Weather {
    private(set) public var location : String;
    private(set) public var country : String;
    private(set) public var temp : String;
    private(set) public var tempMin : String;
    private(set) public var tempMax : String;
    private(set) public var weather : String;
    private(set) public var wind : String;
    
    
    init(location : String, country : String, temp : String, tempMin : String,
         tempMax : String, weather : String, wind : String) {
        self.location = location;
        self.country = country;
        self.temp = temp;
        self.tempMax = tempMax;
        self.tempMin = tempMin;
        self.weather = weather;
        self.wind = wind;
    }
    
    
}
