//
//  VenueController.swift
//  Foursquare
//
//  Created by Preet G S Anand on 10/17/17.
//  Copyright © 2017 Preet G S Anand. All rights reserved.
//

import UIKit
import CoreLocation

class SearchController: UIViewController, CLLocationManagerDelegate,UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    
    
    
    let manager = CLLocationManager()
    var searchText : String = "";
    @IBOutlet weak var venueCollection : UICollectionView?
    
    var venueList = [Venue]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let venueCol = self.venueCollection {
            venueCol.delegate = self;
            venueCol.dataSource = self;
        }
        
    }
    
    
    func initializeParameters(searchText : String) {
        manager.delegate = self;
        self.searchText = searchText;
        manager.requestWhenInUseAuthorization()
        manager.requestAlwaysAuthorization()
        
        manager.desiredAccuracy = kCLLocationAccuracyBest
        
        manager.startUpdatingLocation()
        
        manager.startMonitoringSignificantLocationChanges()
        
        
        if CLLocationManager.locationServicesEnabled()
        {
            switch(CLLocationManager.authorizationStatus())
            {
                
            case .authorizedAlways, .authorizedWhenInUse:
                
                print("Authorize.")
                
                break
                
            case .notDetermined:
                
                print("Not determined.")
                
                break
                
            case .restricted:
                
                print("Restricted.")
                
                break
                
            case .denied:
                
                print("Denied.")
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let venueCol = self.venueCollection {
            return CGSize(width : venueCol.frame.width - 1,
                          height : 150);
        }
        else {
            return CGSize(width : 0,
                          height : 0);
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print(location.coordinate);
            ApiService.instance.callVenueSearchApi(query: searchText, lat: location.coordinate.latitude, lng: location.coordinate.longitude,  completion: { (success) in
                if success {
                    self.venueList = ApiService.instance.getVenueList()
                    if let venueCol = self.venueCollection {
                        venueCol.reloadData()
                    }
                }
                else {
                    print("Error");
                }
            })
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location Failed \(error)");
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.denied {
            showLocationDisabledPopUp();
        }
    }
    
    func showLocationDisabledPopUp() {
        let alertController = UIAlertController(title: "Background Location Access Disabled",
                                                message: "In order to deliver pizza we need your location",
                                                preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let openAction = UIAlertAction(title: "Open Settings", style: .default) { (action) in
            if let url = URL(string: UIApplicationOpenSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        alertController.addAction(openAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return venueList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let venueCell = venueCollection?.dequeueReusableCell(withReuseIdentifier: "VenueCell", for: indexPath) as? VenueCell {
            
            venueCell.updateViews(venue: self.venueList[indexPath.row]);
            return venueCell
        }
        else {
            return VenueCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let venueId = self.venueList[indexPath.row].id
        performSegue(withIdentifier: "VenueDetailController", sender: venueId)
    }
    
    override
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let venueDetailController = segue.destination as? VenueDetailController {
            if let venueId = sender as? String {
                venueDetailController.initializeParameters(venueId : venueId)
                
            }
        }
    }
}

