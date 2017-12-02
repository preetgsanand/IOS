//
//  NavigationController.swift
//  ApiDbJsonApp
//
//  Created by Preet G S Anand on 10/22/17.
//  Copyright © 2017 Preet G S Anand. All rights reserved.
//

import UIKit
import RealmSwift
class NavigationController: UINavigationController {
    
    var realm : Realm?
    var SEGUE : Int = 0;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        realm = try! Realm()
        
        if realm?.objects(Employee.self).count != 0 {
            let me = realm?.objects(Employee.self).first
            if me?.name == "" {
                self.pushViewController(InitialDetailController(), animated: true)
            }
        }
        else {
            self.pushViewController(LoginController(), animated: true)
        }
    }

    
    override
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if SEGUE == 0 {
            if let loginController = segue.destination as? LoginController {
                self.pushViewController(loginController, animated: true)
            }
        }
        else if SEGUE == 1 {
            if let employeeController = segue.destination as? EmployeeController {
                self.pushViewController(employeeController, animated: true)
            }
        }
        else if SEGUE == 2 {
            if let initialDetailController = segue.destination as? InitialDetailController {
                if let me = sender as? Employee {
                    initialDetailController.initializeMe(employee: me)
                }
            }
        }
    }
    
    
}
