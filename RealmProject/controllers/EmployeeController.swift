//
//  EmployeeController.swift
//  RealmProject
//
//  Created by Preet G S Anand on 10/16/17.
//  Copyright © 2017 Preet G S Anand. All rights reserved.
//

import UIKit
import RealmSwift


class EmployeeController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,
UICollectionViewDelegateFlowLayout{
    
    
    
    @IBOutlet weak var employeeCollection : UICollectionView?
    var employeeList = [Employee]()
    var realm : Realm?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        realm = try! Realm()
        employeeCollection?.delegate = self;
        employeeCollection?.dataSource = self;
        simulateEmployeeAddition()
        simulateEmployeeFetching()
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let employeeColl = employeeCollection {
            return CGSize(width : employeeColl.frame.width - 2, height : 80);

        }
        else {
            return CGSize(width : 100, height : 100);

        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return employeeList.count
    }
    
    
    func simulateEmployeeAddition() {
        for i in 0...1 {
            let employee = Employee()
            employee.id = String(i)
            employee.name = "User \(i)"
            employee.email = "user\(i)@gmail.com"
            
            try! realm?.write {
                realm?.add(employee,update : true);
            }
        }
    }
    
    func simulateEmployeeFetching() {
        let result = realm?.objects(Employee.self);
        if let list = result {
            employeeList = Array(list);
        }
        print(employeeList.count);
        employeeCollection?.reloadData()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let employeeCell = employeeCollection?.dequeueReusableCell(withReuseIdentifier: "EmployeeCell", for: indexPath) as? EmployeeCell {
            let employee = employeeList[indexPath.row]
            employeeCell.updateViews(employee: employee)
            return employeeCell
    
        }
        else {
            return EmployeeCell()
        }
    }

}
