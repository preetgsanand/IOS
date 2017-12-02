//
//  CustomLocationCell.swift
//  IOSApiProject
//
//  Created by Preet G S Anand on 10/12/17.
//  Copyright © 2017 Preet G S Anand. All rights reserved.
//

import UIKit

class CustomLocationCell: UICollectionViewCell {
    @IBOutlet weak var country : UILabel!
    @IBOutlet weak var location : UILabel!
    @IBOutlet weak var tempMin : UILabel!
    @IBOutlet weak var tempMax : UILabel!
    @IBOutlet weak var weatherIcon : UIImageView!
    
    func updateView(weather : Weather) {
        country.text = weather.country
        location.text = weather.location
        tempMin.text = weather.tempMin+"\u{00B0}C"
        tempMax.text = weather.tempMax+"\u{00B0}C"
        
        if weather.weather.lowercased().contains("clear") {
            weatherIcon.image = UIImage(named : "sun");
        }
        else if weather.weather.lowercased().contains("clouds") {
            weatherIcon.image = UIImage(named : "cloud");

        }
        else if weather.weather.lowercased().contains("rain") {
            weatherIcon.image = UIImage(named : "rain");

        }
        else if weather.weather.lowercased().contains("thunderstorm") {
            weatherIcon.image = UIImage(named : "thunderstorm");

        }
        else if weather.weather.lowercased().contains("snow") {
            weatherIcon.image = UIImage(named : "snow");

        }
        else if weather.weather.lowercased().contains("mist") {
            weatherIcon.image = UIImage(named : "mist");

        }
        else if weather.weather.lowercased().contains("haze") {
            weatherIcon.image = UIImage(named : "haze");
            
        }
    }
}
