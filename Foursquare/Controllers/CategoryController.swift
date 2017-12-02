w//
//  CategoryController.swift
//  Foursquare
//
//  Created by Preet G S Anand on 10/17/17.
//  Copyright © 2017 Preet G S Anand. All rights reserved.
//

import UIKit

class CategoryController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{
    
    
    
    

    @IBOutlet weak var categoryCollection : UITableView?
    var categoryList = [String]();
    @IBOutlet weak var searchBar : UISearchBar?
    var SEGUE : Int = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryCollection?.delegate = self;
        categoryCollection?.dataSource = self;
        categoryList = categories;
        searchBar?.delegate = self;
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryList.count

    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        performSegue(withIdentifier: "SearchController", sender: searchBar.text);
        SEGUE = 0;
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height : CGFloat = CGFloat()
        if let categoryCol = categoryCollection {
            height = categoryCol.frame.height/6;
            return height
        }
        else {
            return 0
        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let categoryCell = categoryCollection?.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as? CategoryTableCell{
            categoryCell.updateViews(category: categoryList[indexPath.row],
                                     position : indexPath.row)
            return categoryCell
        }
        else {
            return CategoryTableCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let categoryId = categoryIds[indexPath.row]
        performSegue(withIdentifier: "VenueController", sender: categoryId);
        SEGUE = 1;
    }

    
    override
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if SEGUE == 1 {
            if let venueController = segue.destination as? VenueController {
                if let categoryId = sender as? String {
                    venueController.initializeParameters(categoryId : categoryId);
                    
                }
            }
        }
        else if SEGUE == 0 {
            if let searchController = segue.destination as? SearchController {
                if let search = sender as? String {
                    searchController.initializeParameters(searchText : search);
                    
                }
            }
        }
    }

}
