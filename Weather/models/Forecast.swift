//
//  Forecast.swift
//  IOSApiProject
//
//  Created by Preet G S Anand on 10/13/17.
//  Copyright © 2017 Preet G S Anand. All rights reserved.
//

import Foundation

struct Forecast {
    var date : String;
    var tempMin : String;
    var tempMax : String;
    var pressure : String;
    var humidity : String;
    var weather : String;
    
    init(date : String, tempMin : String, tempMax : String, pressure : String,
         humidity : String, weather : String) {
        self.date = date;
        self.tempMin = tempMin;
        self.tempMax = tempMax;
        self.pressure = pressure;
        self.humidity = humidity;
        self.weather = weather;
    }
}
