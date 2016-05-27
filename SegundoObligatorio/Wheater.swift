//
//  Wheater.swift
//  SegundoObligatorio
//
//  Created by Administrador on 27/5/16.
//  Copyright © 2016 Universidad Catolica. All rights reserved.
//

import Foundation
import ObjectMapper

class Wheater: Mappable {
    
    var icon: NSString?
    required init?(_ map: Map) {
    }
    
    func mapping(map: Map) {
        self.icon <- map["icon"]
    }
    
}
