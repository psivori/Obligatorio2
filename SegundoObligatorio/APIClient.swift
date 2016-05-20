//
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

class APIClient {
    
    static let sharedClient = APIClient()
    
    private let baseURL = "//http://api.openweathermap.org/data/2.5/forecast/daily?mode=json&units=metric&cnt=7&APPID=7ee24321e531ad99d44cbfc4aece88f9"
    //api.openweathermap.org/data/2.5/forecast/daily?lat=35&lon=139&cnt=10
    
    private init() {
        
    }
    
    func charactersOnCompletion(onCompletion: (characters: [Character]?, error: NSError?) -> Void) {
        
        
        Alamofire.request(.GET, self.baseURL + "/users").validate().responseJSON { (response: Response<AnyObject, NSError>) -> Void in
            
//            switch response.result {
//                
//            case .Failure(let error):
//                onCompletion(characters: nil, error: error)
//            case .Success(let value):
//                
//                if let characters = Mapper<Character>().mapArray(value) {
//                    
//                    onCompletion(characters: characters, error: nil)
//                }else {
//                    onCompletion(characters: nil, error: NSError(domain: "MyApp", code: 9999, userInfo: [NSLocalizedDescriptionKey: "Fallo el mapeo"]))
//                }
//            }
            
        }
    }
    
}
