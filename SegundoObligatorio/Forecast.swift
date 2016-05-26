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
    
    //{"dt":1463796000,"temp":{"day":305.27,"min":292.62,"max":306.51,"night":296.57,"eve":303.08,"morn":292.62},"pressure":990.6,"humidity":53,"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01d"}],"speed":1.42,"deg":55,"clouds":0}
    
    //units=imperial
    //units=metric    
    var icon: NSObject?
    var day: NSNumber?
    var temp: NSNumber?
    required init?(_ map: Map) {
        
        
    }
        
    func mapping(map: Map) {
        
        self.icon <- map["weather.icon"]
        
        self.day <- map["dt"]
        
        self.temp <- map["temp.day"]
        
    }
    
    
    
}