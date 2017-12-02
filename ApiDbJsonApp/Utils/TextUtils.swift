//
//  TextUtils.swift
//  ApiDbJsonApp
//
//  Created by Preet G S Anand on 10/16/17.
//  Copyright © 2017 Preet G S Anand. All rights reserved.
//

import Foundation

func isValidEmail(email:String) -> Bool {
    
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    let result = emailTest.evaluate(with: email)
    return result
    
}


