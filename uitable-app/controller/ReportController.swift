	//
//  ReportController.swift
//  uitable-app
//
//  Created by Preet G S Anand on 10/12/17.
//  Copyright © 2017 Preet G S Anand. All rights reserved.
//

import UIKit

class ReportController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,
UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var reportCollection : UICollectionView!
    private(set) public var reports = [Report]();
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataService.instance.getReports().count
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = reportCollection.frame.width/2;
        return CGSize(width : reportCollection.frame.width/2 - 6, height : reportCollection.frame.height/2);
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomReportCellCollectionViewCell", for: indexPath) as? CustomReportCellCollectionViewCell {
            let report = reports[indexPath.row]
            cell.udpateViews(report: report);
            return cell;
        }
        else {
            return CustomReportCellCollectionViewCell();
        }
    }
    
    func initReports() {
        reports = DataService.instance.getReports();
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        reportCollection.dataSource = self;
        reportCollection.delegate = self;
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
