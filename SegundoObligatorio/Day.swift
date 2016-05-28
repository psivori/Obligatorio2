//
//  Day.swift
//  SegundoObligatorio
//
//  Created by Administrador on 27/5/16.
//  Copyright © 2016 Universidad Catolica. All rights reserved.
//

import Foundation

class Day{
    
    var name : String? = ""
    var condition : Int? = -1
    var icon : String? = ""
    var temp : String? = ""
    
    init(name: String? = nil, andicon icon : String? = nil ,andtemp temp: String? = nil, andCondition condition : Int? = nil ){
        
        self.name = name
        self.condition = condition
        self.icon = icon
        self.temp = temp
    }
    
    
    
    
}
