//
//  DataService.swift
//  IOSApiProject
//
//  Created by Preet G S Anand on 10/12/17.
//  Copyright © 2017 Preet G S Anand. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class DataService {
    
    static let instance = DataService();
    private(set) public var weatherList = [Weather]();
    //private(set) public var forecastList = [Forecast]();
    public var forecastList = [
        Forecast(date : "26 Jan, 2017",
                 tempMin : "19",
                 tempMax : "28",
                 pressure : "2",
                 humidity : "4",
                 weather : "Clouds")
    ];
//    private(set) public var weatherList = [
//        Weather(location : "New Delhi",
//                country : "India",
//                temp : "26",
//                tempMin : "18",
//                tempMax : "28",
//                weather : "Clouds",
//                wind : "24 km/hr"),
//        Weather(location : "Mumbai",
//                country : "India",
//                temp : "26",
//                tempMin : "18",
//                tempMax : "28",
//                weather : "Clouds",
//                wind : "24 km/hr"),
//        Weather(location : "Banglore",
//                country : "India",
//                temp : "26",
//                tempMin : "18",
//                tempMax : "28",
//                weather : "Clouds",
//                wind : "24 km/hr")]
//
    func getWeather() -> [Weather] {
        return weatherList;
    
    }
    
    func getForecast() -> [Forecast] {
        return forecastList;
        
    }
    
    func callWeatherApi(location : String, completion : @escaping CompletionHandler) {
        let parameters : Parameters = [
            "q" : location
        ];
        let headers = [
            "X-API-KEY" : ACCESS_KEY
        ];
        
        Alamofire.request(API_WEATHER_URL, parameters : parameters, headers : headers).validate().responseString { (response) in
            
            if response.result.error != nil {
                debugPrint(response.result.error!);
                completion(false);
            }
            else {
                let actualData = JSON(data:response.data!)
                
                let location = actualData["name"].stringValue;
                let country = actualData["sys"]["country"].stringValue;
                let temp = actualData["main"]["temp"].floatValue - 273.15;
                let tempMin = actualData["main"]["temp_min"].floatValue - 273.15;
                let tempMax = actualData["main"]["temp_max"].floatValue - 273.15;
                let wind = actualData["wind"]["speed"].stringValue;
                let weather = actualData["weather"][0]["main"].stringValue;

                self.weatherList.append(Weather(location : location,
                                           country : country,
                                           temp : String(temp),
                                           tempMin : String(tempMin),
                                           tempMax : String(tempMax),
                                           weather : weather,
                                           wind : wind));
                completion(true);
            }
        }
    }
    
    func callForecastApi(location : String, completion : @escaping CompletionHandler) {
        let parameters : Parameters = [
            "q" : location
        ];
        let headers = [
            "X-API-KEY" : ACCESS_KEY
        ];
        
        Alamofire.request(API_FORECAST_URL, parameters : parameters, headers : headers).validate().responseString { (response) in
            
            if response.result.error != nil {
                debugPrint(response.result.error!);
                completion(false);
            }
            else {
                
                //Clearing forecast
                self.forecastList.removeAll();
                
                let actualData = JSON(data:response.data!)
                let list = actualData["list"].arrayValue;
                
                for i in 0...list.count-1 {
                    let forecast = list[i];
                    let date = MilliToFormattedDate(milli: forecast["dt"].doubleValue);
                    
                    let min = forecast["temp"]["min"].floatValue-273.15;
                    let max = forecast["temp"]["max"].floatValue-273.15;
                    let pressure = forecast["pressure"].intValue;
                    let humidity = forecast["humidity"].stringValue;
                    let weather = forecast["weather"][0]["main"].stringValue;
                    
                    self.forecastList.append(Forecast(date : date,
                                                      tempMin : String(min),
                                                      tempMax : String(max),
                                                      pressure : String(pressure),
                                                      humidity : humidity,
                                                      weather : weather));
                }
                
                completion(true);
            }
        }
    }
    

}
