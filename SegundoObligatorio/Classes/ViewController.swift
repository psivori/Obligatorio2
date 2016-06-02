//
//  ViewController.swift
//  SegundoObligatorio
//
//  Created by Diego Pais on 5/18/16.
//  Copyright © 2016 Universidad Catolica. All rights reserved.
//

import UIKit
import SwiftLocation
import SwiftyJSON
import MapKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var lblTemperature: UILabel!
    @IBOutlet weak var weatherIconLabel: UILabel!
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    let reuseIdentifier = "cell"
    var lstDays = [Day]()
    let defaults = NSUserDefaults.standardUserDefaults()
    var units : String = "metric"//celsius
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
        
    }
        
    // tell the collection view how many cells to make
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        //return self.items.count
        return self.lstDays.count
        }
    
    // make a cell for each cell index path
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! MyCollectionViewCell
        
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        if(self.lstDays.count > 0){
        cell.lblDay.text = self.lstDays[indexPath.item].name
        
            let temp : String
            let degrees  = String(((self.lstDays[indexPath.item].temp!) as NSString).integerValue)
            if(self.units == "imperial"){
                temp = degrees + " \u{2109}"// FAHRENHEIT
            }else{
                temp = degrees + " \u{2103}"// Celsius
            }

            cell.lblTemp.text = temp
            cell.lblIcon.text = WeatherIcon(condition: Int(self.lstDays[indexPath.item].condition!), iconString: String(self.lstDays[indexPath.item].icon) ).iconText
            }
            return cell
    }
    

    
    override func viewDidAppear(animated: Bool) {
        
        self.activityIndicator.startAnimating()
        if (defaults.stringForKey("units") != nil){
            
            self.units = defaults.stringForKey("units")!
        }
        
        super.viewDidAppear(true)
        do {
            
            try SwiftLocation.shared.currentLocation(Accuracy.Neighborhood, timeout: 20, onSuccess: { (location) -> Void in
                
                var myLocation = location?.coordinate
                
                var lat :Double
                var lng :Double
                
                if self.defaults.boolForKey("currentLocation"){
                    lat = location!.coordinate.latitude
                    lng = location!.coordinate.longitude
                    self.defaults.setDouble(lat, forKey: "currentLatitude")
                    self.defaults.setDouble(lng, forKey: "currentLongitude")
                }else{
                    lat = self.defaults.doubleForKey("currentLatitude")
                    lng = self.defaults.doubleForKey("currentLongitude")
                    myLocation = CLLocationCoordinate2D(latitude: lat, longitude: lng)
                }
                
                SwiftLocation.shared.reverseCoordinates(Service.Apple, coordinates: myLocation!, onSuccess: { (place) -> Void in
                    // our placemark is here
                    self.lblCity.text = place!.locality
                    print(place!.locality)
                    }) { (error) -> Void in
                        // something went wrong
                }
                
                APIWheater.sharedWheater.forecastOnCompletion(String(lat), longitude: String(lng), units: self.units) { (forecasts, error) -> Void in
                    if let forecasts = forecasts {
                        
                        //Load Days
                        self.lstDays.removeAll()
                        var first: Bool = false
                        for fcast in forecasts{
                            let day = Day(name: fcast.day!, andicon: String(fcast.icon!), andtemp: String(fcast.temp!), andCondition: Int(fcast.condition!))
                            if !first{
                                first = true
                            }else{
                                self.lstDays.append(day)
                            }
                        }
                        
                        //Forecast for current date always in first position
                        //Showing temperature
                        if(forecasts[0].temp != nil ){
                            let temp : String
                            if(self.units == "imperial"){
                                    temp = String(Int(forecasts[0].temp!)) + " \u{2109}"//FAHRENHEIT
                            }else{
                                    temp = String(Int(forecasts[0].temp!)) + " \u{2103}"// Celsius
                            }

                            self.lblTemperature.text = temp
                        }else{
                            self.lblTemperature.text = "No temperature"
                        }
                        //Showing icon
                        if(forecasts[0].icon != nil ){
                            
                            self.weatherIconLabel.text = WeatherIcon(condition: Int(self.lstDays[0].condition!), iconString: String(self.lstDays[0].icon) ).iconText
                        }
                        self.collectionView.reloadData()
                        
                    }else {
                        let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .Alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
                        self.presentViewController(alert, animated: true, completion: nil)
                    }
                    
                }
                
                self.activityIndicator.stopAnimating()
                }) { (error) -> Void in
                    // something went wrong
                    self.activityIndicator.stopAnimating()
                    let alertController = UIAlertController(title: "Error", message:
                        error?.description, preferredStyle: UIAlertControllerStyle.Alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
                    self.presentViewController(alertController, animated: true, completion: nil)
            }
        } catch {
            self.activityIndicator.stopAnimating()
            let alertController = UIAlertController(title: "Error", message:
                "Error getting current location", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        
    }



}

