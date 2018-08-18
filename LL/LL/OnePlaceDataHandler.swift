//
//  OnePlaceDataHandler.swift
//  AllHere
//
//  Created by Maria Susana Moline Venanzi on 4/1/18.
//  Copyright © 2018 HRApps. All rights reserved.
//

import Foundation


class OnePlaceDataHandler {
    
    let data1 : Data
    var onePlaceJSONData : OnePlaceData?
    var lugar : String?
    
    init(_data: Data) {
        self.data1 = _data
}

    func decodeData() {
        
        let decoder = JSONDecoder()
        
        do {
            
           onePlaceJSONData = try decoder.decode(OnePlaceData.self, from: self.data1)
            print(onePlaceJSONData!)
           // lugar = onePlaceJSONData?.response.venue.name
            
           // print(lugar)
            
        } catch  {
            print(error)
        }
        
        
    }
    
}
