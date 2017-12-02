//
//  ApiService.swift
//  Foursquare
//
//  Created by Preet G S Anand on 10/17/17.
//  Copyright © 2017 Preet G S Anand. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ApiService {
    static let instance = ApiService()
    private(set) var venueList : [Venue] = [Venue]();
    private(set) var venueDetail : Venue?
    
    func getVenueList() -> [Venue] {
        return self.venueList;
    }
    
    func getVenueDetail() -> Venue {
        return venueDetail!
    }
    func callVenueSearchApi(query : String, lat : Double,
                            lng : Double, completion : @escaping CompletionHandler) {
        let parameters : Parameters = [
            "v": "20131016",
            "ll" : String(lat)+","+String(lng),
            "client_id" : CLIENT_ID,
            "client_secret" : CLIENT_SECRET,
            "query" : query,
            "intent":"browse",
            "radius":"10000"
        ]
        
        Alamofire.request(VENUE_SEARCH_URL, parameters : parameters).validate().responseString { (response) in
            
            if(response.result.error != nil) {
                completion(false);
            }
            else {
                self.venueList.removeAll();
                if let data = response.data {
                    print(data);
                    let dataJSON = JSON(data: data)
                    self.parseVenueList(dataJSON: dataJSON,completion: completion);
                }
            }
        }
    }
    
    func callVenueDetailApi(venueId : String, completion : @escaping CompletionHandler) {
        let parameters : Parameters = [
            "v": "20131016",
            "client_id" : CLIENT_ID,
            "client_secret" : CLIENT_SECRET
        ]
        
        Alamofire.request(VENUE_DETAIL_URL+venueId, parameters : parameters).validate().responseString { (response) in
            if response.result.error != nil {
                if let error = response.result.error {
                    print(error)
                    completion(false)
                    
                }
            }
            else {
                if let data = response.data {
                    let dataJSON = JSON(data:data)
                    self.parseVenueDetail(venueId : venueId,dataJSON: dataJSON, completion: completion);
                }
            }
        }
    }
    
    func callVenueByCategorySearchApi(categoryId : String,lat : Double,
                                      lng : Double, completion : @escaping CompletionHandler) {
        let parameters : Parameters = [
            "v": "20131016",
            "ll" : String(lat)+","+String(lng),
            "categoryId" : categoryId,
            "client_id" : CLIENT_ID,
            "client_secret" : CLIENT_SECRET
        ]
        
        Alamofire.request(VENUE_SEARCH_URL, parameters : parameters).validate().responseString { (response) in
            
            if response.result.error != nil {
                if let error = response.result.error {
                    print(error)
                    completion(false)

                }
            }
            else {
                self.venueList.removeAll();
                if let data = response.data {
                    let dataJSON = JSON(data:data)
                    self.parseVenueList(dataJSON: dataJSON,completion : completion);
                }
                    
            }
        }
        
    }
    
    
    func parseVenueList(dataJSON : JSON, completion : @escaping CompletionHandler ) {
        let venueArray = dataJSON["response"]["venues"].arrayValue;
        
        for i in 0..<venueArray.count {
            let venueJSON = venueArray[i]
            
            let id = venueJSON["id"].stringValue;
            let name = venueJSON["name"].stringValue;
            let lat = venueJSON["location"]["lat"].doubleValue
            let lng = venueJSON["location"]["lng"].doubleValue
            let distance = venueJSON["location"]["distance"].doubleValue
            var formattedAddressArr = venueJSON["location"]["formattedAddress"].arrayValue
            var address = ""
            for j in 0..<formattedAddressArr.count {
                if j == 0 {
                    address = formattedAddressArr[j].stringValue
                    
                }
                else {
                    address = address+"\n"+formattedAddressArr[j].stringValue
                    
                }
            }
            var categoryArray = venueJSON["categories"].arrayValue
            var category = "";
            if(categoryArray.count != 0) {
                category = categoryArray[0]["name"].stringValue
            }
            let checkins = venueJSON["stats"]["checkinsCount"].doubleValue
            let users = venueJSON["stats"]["usersCount"].doubleValue
            let tips = venueJSON["stats"]["tipCount"].doubleValue
            
            let venue = Venue(lat : lat, lng : lng,
                              address  :address, checkins : checkins,
                              users : users, tips : tips,
                              category : category, distance : distance,
                              id : id, name: name)
            self.venueList.append(venue)
            completion(true)
            
        }
    }
    
    func parseVenueDetail(venueId : String, dataJSON : JSON, completion : @escaping CompletionHandler) {
        let venueJSON = dataJSON["response"]["venue"]
        for i in 0..<venueList.count {
            if venueList[i].id.contains(venueId) {
                self.venueDetail = venueList[i];
                break;
            }
        }
        
        if self.venueDetail != nil {
            let phone = venueJSON["contact"]["formattedPhone"].stringValue
            let url = venueJSON["url"].stringValue
            let visits = venueJSON["stats"]["visitsCount"].double
            let price = venueJSON["price"]["message"].stringValue
            let ratings = venueJSON["rating"].floatValue
            let imageUrl = venueJSON["bestPhoto"]["prefix"].stringValue+"375x250"+venueJSON["bestPhoto"]["suffix"].stringValue
            
            
            self.venueDetail?.phone = phone;
            self.venueDetail?.url = url;
            self.venueDetail?.visits = visits;
            self.venueDetail?.price = price;
            self.venueDetail?.rating = ratings;
            self.venueDetail?.imageUrl = imageUrl;
            
            completion(true);

        }
        else {
            completion(false)
        }
    }
}
