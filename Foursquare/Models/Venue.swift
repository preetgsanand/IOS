//
//  Venue.swift
//  Foursquare
//
//  Created by Preet G S Anand on 10/17/17.
//  Copyright © 2017 Preet G S Anand. All rights reserved.
//

import Foundation

struct Venue {
    var lat : Double;
    var lng : Double;
    var address : String;
    var checkins : Double;
    var users : Double;
    var tips : Double;
    var category : String;
    var distance : Double;
    var id : String;
    var name : String;
    var rating : Float?
    var phone : String?
    var url : String?
    var price : String?
    var visits : Double?
    var imageUrl : String?

    init(lat : Double, lng : Double, address : String, checkins : Double,
         users : Double, tips : Double, category : String, distance : Double,
         id : String, name : String, rating : Float = 0.0 , phone : String = "",
         url : String = "", price : String = "", visits : Double = 0, imageUrl : String = "") {
        self.lat = lat;
        self.lng = lng;
        self.address = address;
        self.checkins = checkins;
        self.users = users;
        self.tips = tips;
        self.category = category;
        self.distance = distance;
        self.id = id;
        self.name = name;
        self.rating = rating;
        self.phone = phone;
        self.url = url;
        self.price = price;
        self.visits = visits;
        self.imageUrl = imageUrl;
    }

}
