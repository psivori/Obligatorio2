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
    var day: NSNumber?
    var temp: NSNumber?
    var icon: NSString?
    required init?(_ map: Map) {
        
        
    }
        
    func mapping(map: Map) {
        self.wheater <-  map["weather"]
        self.icon = (self.wheater?.firstObject as! NSDictionary)["icon"] as! NSString
        self.day <- map["dt"]
        self.temp <- map["temp.day"]
    
    }
    
    
    
}