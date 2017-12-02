//
//  ViewController.swift
//  CoreData1
//
//  Created by Preet G S Anand on 10/16/17.
//  Copyright © 2017 Preet G S Anand. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var employeeTable : UITableView?
    var employeeList = [User]();
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        employeeTable?.delegate = self;
        employeeTable?.dataSource = self;
        simulateCoreDataEmployeeAddition()
        simulateCoreDataEmployeeFetching()
    }
    
    func simulateCoreDataEmployeeFetching() {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate;
        let managedObjectContext = appDelegate?.persistentContainer.viewContext
        
        do {
            let records =  try managedObjectContext?.fetch(User.fetchRequest())
            employeeList = records as! [User]
            employeeTable?.reloadData()
            
        } catch(let errror) {
            debugPrint(errror.localizedDescription);
        }
    }
    
    func simulateCoreDataEmployeeAddition() {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate;
        let managedObjectContext = appDelegate?.persistentContainer.viewContext;
        
        let employee = User(context : managedObjectContext!)
        employee.name = "Preet G S Anand";
        
        managedObjectContext?.insert(employee)
        
        appDelegate?.saveContext();
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employeeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let employeeCell = employeeTable?.dequeueReusableCell(withIdentifier: "EmployeeCell") as?
            EmployeeCell {
            let employee = employeeList[indexPath.row]
            employeeCell.updateViews(employee : employee);
            return employeeCell
        }
        else {
            return EmployeeCell()
        }
    }
}

