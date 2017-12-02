//
//  LoginViewDelegate.swift
//  Trello
//
//  Created by Preet G S Anand on 11/2/17.
//  Copyright © 2017 Preet G S Anand. All rights reserved.
//

import Foundation

protocol LoginViewDelegate {
    func publishApiResult(_ success : Bool, _ message : String)
    func callBoardSegue()
}
