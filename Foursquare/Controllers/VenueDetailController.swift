//
//  VenueDetailController.swift
//  Foursquare
//
//  Created by Preet G S Anand on 10/18/17.
//  Copyright © 2017 Preet G S Anand. All rights reserved.
//

import UIKit
import Nuke

class VenueDetailController: UIViewController {
    
    @IBOutlet weak var venueName : UILabel?
    @IBOutlet weak var address : UILabel?
    @IBOutlet weak var checkins : UILabel?
    @IBOutlet weak var users : UILabel?
    @IBOutlet weak var tips : UILabel?
    @IBOutlet weak var visits : UILabel?
    @IBOutlet weak var venunePrice : UILabel?
    @IBOutlet weak var ratings : UILabel?
    @IBOutlet weak var url : UILabel?
    @IBOutlet weak var phone : UILabel?
    @IBOutlet weak var image : UIImageView?

    
    
    var venueId : String = "";
    var venue : Venue?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
    func initializeParameters(venueId : String) {
        self.venueId = venueId;
        ApiService.instance.callVenueDetailApi(venueId: self.venueId) { (success) in
            if(success) {
                self.venue = ApiService.instance.getVenueDetail()
                self.setVenueParameters();
            }
            else {
                print("Error");
            }
        }
    }
    
    func setVenueParameters() {
        if let venue = self.venue {
            venueName?.text = venue.name;
            address?.text = venue.address;
            checkins?.text = "Checkins : "+String(Int(venue.checkins.rounded()));
            users?.text = "Users : "+String(Int(venue.users.rounded()));
            tips?.text = "Tips : "+String(Int(venue.tips.rounded()));
            if let visit = venue.visits {
                visits?.text = "Visits : "+String(Int(visit.rounded()));
            }
            else {
                visits?.text = "NA";
            }
            if venue.price != nil {
                venunePrice?.text = venue.price;
            }
            else {
                venunePrice?.text = "NA";
            }
            if let rat = venue.rating {
                ratings?.text = "\(rat)";
            }
            else {
                ratings?.text = "NA";
            }
            if venue.url != nil {
                url?.text = venue.url;
            }
            else {
                url?.text = "NA";
            }
            if venue.phone != nil {
                phone?.text = venue.phone;
            }
            else {
                phone?.text = "NA";
            }
            
            if let url = venue.imageUrl {
                let Url = URL(string : url);
                Nuke.loadImage(with: Url!, into: image!)

            }
        }
    }
}
