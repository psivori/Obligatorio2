//
//  ViewController.swift
//  SegundoObligatorio
//
//  Created by Diego Pais on 5/18/16.
//  Copyright © 2016 Universidad Catolica. All rights reserved.
//

import UIKit

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


}

