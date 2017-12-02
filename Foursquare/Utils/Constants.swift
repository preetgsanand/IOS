//
//  Constants.swift
//  Foursquare
//
//  Created by Preet G S Anand on 10/17/17.
//  Copyright © 2017 Preet G S Anand. All rights reserved.
//

import Foundation


let CLIENT_ID = "R0AN30KS33AASPJ1M3HPZ4VPMJNGGTBG1WAN5FMTUQYA5XJQ";
let CLIENT_SECRET = "SIVHJGO2Q5L5QBEZTUCXMR1JY2SRE0YSGBWX3LPDCUJ15PSU";

let VENUE_SEARCH_URL = "https://api.foursquare.com/v2/venues/search";
let VENUE_DETAIL_URL = "https://api.foursquare.com/v2/venues/";

let categories : [String] = [
    "Food",
    "Outdoor & Recreation",
    "Nightlife",
    "Fun",
    "Shop & Services",
    "Travel & Transport"
]

let categoryIds : [String] = [
    "4d4b7105d754a06374d81259",
    "4d4b7105d754a06377d81259",
    "4d4b7105d754a06376d81259",
    "4d4b7104d754a06370d81259",
    "4d4b7105d754a06378d81259",
    "4d4b7105d754a06379d81259"
    
]

typealias CompletionHandler = (_ Success : Bool) -> ()



