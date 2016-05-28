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
    var day: String?
    required init?(_ map: Map) {
        
        
    }
        
    func mapping(map: Map) {
        self.wheater <-  map["weather"]
        self.icon = (self.wheater?.firstObject as! NSDictionary)["icon"] as! NSString
        self.date <- (map["dt"], DateTransform())
        self.temp <- map["temp.day"]
        
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Weekday], fromDate: date)
        
        //let myComponents = myCalendar?.components(.WeekdayCalendarUnit, fromDate: self.date)
        self.day = components?.Weekday
    }
    
    
    
}