//
//  MainTabController.swift
//  ApiDbJsonApp
//
//  Created by Preet G S Anand on 10/26/17.
//  Copyright © 2017 Preet G S Anand. All rights reserved.
//

import UIKit
import RealmSwift

class MainTabController: UITabBarController {
    var realm : Realm!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkInitialSetup()
        
    }
    
    func checkInitialSetup() {
        realm = try! Realm()
        if realm?.objects(Employee.self).count != 0 {
            let me = realm?.objects(Employee.self).first
            if me?.name == "" {
                performSegue(withIdentifier: "TabToInitialDetailSegue", sender: nil)
            }
            else {
                setNavigationBar()
                initializeHandler()
                initializeSocket()
            }
        }
        else {
            performSegue(withIdentifier: "TabToLoginSegue", sender: nil)
            
        }
        
    }
    
    func setNavigationBar() {
        self.navigationItem.hidesBackButton = true

    }
    
    func initializeSocket() {
        SocketService.instance.emitUserOnline()
    }
    
    
    func initializeHandler() {
        SocketService.instance.setSocketCompletion { (CODE) in
            switch CODE {
            case ON_USER_CONNECTED:
                print("Sokcket connected")
            case ON_REFRESH_USER_LIST:
                print("Employee List Updated")
            case ON_USER_ONLINE:
                print("Employee List Updated")
            case ON_USER_OFFLINE:
                print("Employee List Updated")
            default:
                print("Default")
            }
        }
    }

}
