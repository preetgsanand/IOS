//
//  ViewController.swift
//  uitable-app
//
//  Created by Preet G S Anand on 10/11/17.
//  Copyright © 2017 Preet G S Anand. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var categoryTable : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryTable.dataSource = self;
        categoryTable.delegate = self;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(DataService.instance.getCategories().count);
        return DataService.instance.getCategories().count;
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCategoryCell") as? CustomCategoryCell {
            let category = DataService.instance.getCategories()[indexPath.row]
            cell.updateViews(category: category)
            print("updating")
            return cell
        }
        else {
            return CustomCategoryCell()
        }
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ReportController", sender: Any?.self);
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let reportController = segue.destination as? ReportController {
            reportController.initReports();
        }
    }



}

