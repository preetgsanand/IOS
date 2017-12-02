//
//  DateUtils.swift
//  IOSApiProject
//
//  Created by Preet G S Anand on 10/15/17.
//  Copyright © 2017 Preet G S Anand. All rights reserved.
//

import Foundation

func MilliToFormattedDate(milli : Double) -> String {
    let formattedDate = Date(timeIntervalSince1970 : milli);
    let dateFormatter = DateFormatter();
    dateFormatter.dateStyle = .medium;
    return dateFormatter.string(from: formattedDate);
}
