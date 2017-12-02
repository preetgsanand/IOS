//
//  ForecastController.swift
//  IOSApiProject
//

import UIKit

class ForecastController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout{
    
    
    @IBOutlet weak var forecastCollection : UICollectionView!
    var forecastList : [Forecast] = [];
    private(set) public var location : String = "";
    
    override func viewDidLoad() {
        super.viewDidLoad()
        forecastCollection.dataSource = self;
        forecastCollection.delegate = self;
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width : forecastCollection.frame.width/2-1,
                      height : 220);
    }
    
    func setLocation(location : String) {
        self.location = location;
        DataService.instance.callForecastApi(location: location) { (success) in
            if(success) {
                self.forecastList = DataService.instance.getForecast();
                self.forecastCollection.reloadData();
            }
            else {
                debugPrint("Error");
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return forecastList.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let forecastCell = forecastCollection.dequeueReusableCell(withReuseIdentifier: "CustomForecastCell", for: indexPath) as? CustomForecastCell{
            let forecast = forecastList[indexPath.row];
            forecastCell.updateViews(forecast: forecast);
            return forecastCell;
        }
        else {
            return CustomForecastCell()
        }
    }
    



}
