//
//  ViewController.swift
//  SegundoObligatorio
//
//  Created by Diego Pais on 5/18/16.
//  Copyright © 2016 Universidad Catolica. All rights reserved.
//

import UIKit
import SwiftLocation

class ViewController: UIViewController {

    @IBOutlet weak var weatherIconLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        condition: weather.id
//        iconString: weather.icon
//        ver: http://openweathermap.org/current#parameter
//        http://openweathermap.org/weather-conditions
        


        self.weatherIconLabel.text = WeatherIcon(condition: 200, iconString: "01n").iconText
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        do {
           // aIndicator.startAnimating()
            try SwiftLocation.shared.currentLocation(Accuracy.Neighborhood, timeout: 20, onSuccess: { (location) -> Void in
                SwiftLocation.shared.reverseCoordinates(Service.Apple, coordinates: location!.coordinate, onSuccess: { (place) -> Void in
                    // our placemark is here
                    print(place!.locality)
    
                    }) { (error) -> Void in
                        // something went wrong
                }
                
                //self.aIndicator.stopAnimating()
                }) { (error) -> Void in
                    // something went wrong
                    //self.aIndicator.stopAnimating()
                    let alertController = UIAlertController(title: "Error", message:
                        error?.description, preferredStyle: UIAlertControllerStyle.Alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
                    self.presentViewController(alertController, animated: true, completion: nil)
            }
        } catch {
            //aIndicator.stopAnimating()
            let alertController = UIAlertController(title: "Error", message:
                "Error getting current location", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
        }

    }


}

