///

//  APIClient.swift

//  SegundoObligatorio

//

//  Created by Administrador on 20/5/16.

//  Copyright © 2016 Universidad Catolica. All rights reserved.

//



import Foundation

import Alamofire

import SwiftyJSON

import ObjectMapper



class APIWheater {
    
    
    
    static let sharedWheater = APIWheater()
    
    
    private let baseURL = "http://api.openweathermap.org/data/2.5/forecast/daily?mode=json&cnt=7&APPID=7ee24321e531ad99d44cbfc4aece88f9"
    
    private init() {
        
    }

    
    func forecastOnCompletion(latitude: String, longitude:String, units: String,onCompletion: (forecasts: [Forecast]?, error: NSError?) -> Void) {
        //print(latitude)
        //print(longitude)
        Alamofire.request(.GET, self.baseURL + "&lat=" + latitude + "&lon=" + longitude + "&units=" + units).validate().responseJSON { (response: Response<AnyObject, NSError>) -> Void in
            switch response.result {
            case .Failure(let error):
                onCompletion(forecasts: nil, error: error)
            case .Success(let value):
                var list = value["list"]!
                //print(list)
                if let forecasts = Mapper<Forecast>().mapArray(list) {
                    onCompletion(forecasts: forecasts, error: nil)
                }else {
                    onCompletion(forecasts: nil, error: NSError(domain: "MyApp", code: 9999, userInfo: [NSLocalizedDescriptionKey: "Fallo el mapeo"]))
                }
            }
        }
    }
    
}