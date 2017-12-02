//
//  ViewController.swift
//  MapPractice
//
//  Created by Preet G S Anand on 11/13/17.
//  Copyright © 2017 Preet G S Anand. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    @IBOutlet weak var mapView : MKMapView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        addPin()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func addPin() {
        let locationCoordinate = CLLocationCoordinate2D(latitude : 20,longitude : 78)
        let annotation = MKPointAnnotation()
        annotation.coordinate = locationCoordinate
        annotation.title = "Preet"
        annotation.subtitle = "India"
        mapView.addAnnotation(annotation)
    }


}

