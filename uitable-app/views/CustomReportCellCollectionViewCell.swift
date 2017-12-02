//
//  CustomReportCellCollectionViewCell.swift
//  uitable-app
//
//  Created by Preet G S Anand on 10/12/17.
//  Copyright © 2017 Preet G S Anand. All rights reserved.
//

import UIKit

class CustomReportCellCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var reportTitle : UILabel!
    @IBOutlet weak var reportDescription : UILabel!
    @IBOutlet weak var reportDate : UILabel!
    
    
    func udpateViews(report : Report) {
        
        reportDescription.numberOfLines = 3;

        reportTitle.text = report.title;
        reportDescription.text = report.description;
        reportDate.text = report.date;
    }
    
}
