//
//  ViewController.swift
//  IOSApiProject
//
//  Created by Preet G S Anand on 10/12/17.
//  Copyright © 2017 Preet G S Anand. All rights reserved.
//

import UIKit

class LocationController: UIViewController,UICollectionViewDelegate,
UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{


    @IBOutlet weak var locationCollection : UICollectionView!
    var weatherList : [Weather] = [];
    override func viewDidLoad() {
        super.viewDidLoad()
        self.weatherList = DataService.instance.getWeather();
        locationCollection.dataSource = self;
        locationCollection.delegate = self;
        callWeatherApi(location: "London")
    }
    
    @IBAction func addLocation(_ sender: Any) {
        addLocationDialog()
    }
    
    func callWeatherApi(location : String) {
        DataService.instance.callWeatherApi(location: location) { (success) in
            if(success) {
                debugPrint("Success");
                self.weatherList = DataService.instance.getWeather();
                self.locationCollection.reloadData()
                
            }
            else {
                debugPrint("Error");
            }
        }
    }

    
    func addLocationDialog() {
        let locationDialog = UIAlertController(title: "Enter Location", message: "Enter the location for weather data", preferredStyle: .alert)

        let confirmAction = UIAlertAction(title:"Enter", style : .default) { (_) in
            
            let location = locationDialog.textFields?[0].text;
            self.callWeatherApi(location: location!);
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in
            
        }
        
        locationDialog.addTextField { (textField) in
            textField.placeholder = "Enter location"
        }
        
        locationDialog.addAction(confirmAction);
        locationDialog.addAction(cancelAction);
        
        self.present(locationDialog, animated: true, completion: nil);
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let location = weatherList[indexPath.row].location;
        performSegue(withIdentifier: "LocationController", sender: location)
    }
    
    
    override
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let forecastController = segue.destination as? ForecastController {
            forecastController.setLocation(location: sender as! String);
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width : locationCollection.frame.width - 2,
                      height : 100);
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherList.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let locationCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomLocationCell", for: indexPath) as? CustomLocationCell {
            let weather = weatherList[indexPath.row];
            locationCell.updateView(weather: weather);
            return locationCell;
        }
        else {
            return CustomLocationCell();
        }
    }

}

