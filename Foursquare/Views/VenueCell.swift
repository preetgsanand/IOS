//
//  VenueCell.swift
//  Foursquare
//
//  Created by Preet G S Anand on 10/17/17.
//  Copyright © 2017 Preet G S Anand. All rights reserved.
//

import UIKit

class VenueCell: UICollectionViewCell {
    @IBOutlet weak var name : UILabel?
    @IBOutlet weak var address : UILabel?
    @IBOutlet weak var distance : UILabel?
    @IBOutlet weak var checkins  : UILabel?
    @IBOutlet weak var users : UILabel?
    @IBOutlet weak var tips : UILabel?
    
    func updateViews(venue : Venue) {
        self.address?.text = venue.address
        self.distance?.text = String(venue.distance/1000)+"Km"
        self.checkins?.text = "Checkins : "+String(Int(venue.checkins.rounded()))
        self.users?.text = "Users : "+String(Int(venue.checkins.rounded()))
        self.tips?.text = "Tips : "+String(Int(venue.tips.rounded()))
        self.name?.text = venue.name
    }
}
