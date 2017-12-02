//
//  CustomForecastCell.swift
//  IOSApiProject
//
//  Created by Preet G S Anand on 10/13/17.
//  Copyright © 2017 Preet G S Anand. All rights reserved.
//

import UIKit

class CustomForecastCell: UICollectionViewCell {
    
    @IBOutlet weak var date : UILabel!
    @IBOutlet weak var tempMax : UILabel!
    @IBOutlet weak var tempMin : UILabel!
    @IBOutlet weak var pressure : UILabel!
    @IBOutlet weak var humidity : UILabel!
    @IBOutlet weak var weatherIcon : UIImageView!
    
    func updateViews(forecast : Forecast) {
        self.date.text = forecast.date;
        self.tempMax.text = "Min : "+forecast.tempMax+"\u{00B0}C";
        self.tempMin.text = "Max : "+forecast.tempMin+"\u{00B0}C";
        self.pressure.text = "Pressure : "+forecast.pressure+" hPa";
        self.humidity.text = "Humidity : "+forecast.humidity+"%";
        
        
        if forecast.weather.lowercased().contains("clear") {
            weatherIcon.image = UIImage(named : "sun");
        }
        else if forecast.weather.lowercased().contains("clouds") {
            weatherIcon.image = UIImage(named : "cloud");
            
        }
        else if forecast.weather.lowercased().contains("rain") {
            weatherIcon.image = UIImage(named : "rain");
            
        }
        else if forecast.weather.lowercased().contains("thunderstorm") {
            weatherIcon.image = UIImage(named : "thunderstorm");
            
        }
        else if forecast.weather.lowercased().contains("snow") {
            weatherIcon.image = UIImage(named : "snow");
            
        }
        else if forecast.weather.lowercased().contains("mist") {
            weatherIcon.image = UIImage(named : "mist");
            
        }
        else if forecast.weather.lowercased().contains("haze") {
            weatherIcon.image = UIImage(named : "haze");
            
        }
        
        
    }
    
}
