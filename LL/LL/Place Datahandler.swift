//
//  Place Datahandler.swift
//  LL
//
//  Created by Maria Susana Moline Venanzi on 4/25/18.
//  Copyright © 2018 HRApps. All rights reserved.
//

import Foundation

class PlacesDataHandler {
    
    let data : Data
    var placeJSONData : PlacesData?
    
    
    init(_data: Data) {
        self.data = _data
    }
    
    func decodeData() {
        
        let decoder = JSONDecoder()
        
        do {
            
            placeJSONData = try decoder.decode(PlacesData.self, from: self.data)
            print(placeJSONData!)
            
        } catch  {
            print(error)
        }
        
        
    }
    
}
