//

//  Forecast.swift

//  SegundoObligatorio

//

//  Created by Administrador on 20/5/16.

//  Copyright © 2016 Universidad Catolica. All rights reserved.

//



import Foundation
import ObjectMapper

class Forecast: Mappable {
        
    var wheater: NSArray?
    var date: NSDate!
    var temp: NSNumber?
    var icon: NSString?
    var condition: NSNumber?
    var day: String?
    required init?(_ map: Map) {
        
        
    }
        
    func mapping(map: Map) {
        self.wheater <-  map["weather"]
        var wheaterDictionary = self.wheater?.firstObject as! NSDictionary
        self.icon = wheaterDictionary["icon"] as! NSString
        self.condition = wheaterDictionary["id"] as! NSNumber
        self.date <- (map["dt"], DateTransform())
        self.temp <- map["temp.day"]
        //formatting date into weekday string
        let dayTimePeriodFormatter = NSDateFormatter()
        dayTimePeriodFormatter.dateFormat = "EEE"
        self.day = dayTimePeriodFormatter.stringFromDate(self.date)
      
    }
    
    
    
}