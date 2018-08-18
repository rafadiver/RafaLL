//
//  Place.swift
//  LL
//
//  Created by Maria Susana Moline Venanzi on 4/25/18.
//  Copyright © 2018 HRApps. All rights reserved.
//


import Foundation
import UIKit

class Place {
    
    var name: String
    var id: String?
    var icon: String?
    var categoryShortName : String?
    var imagen : UIImage?
    var city : String?
    var distance : String?
    var category : String?
    
    
    init(name: String, categoryShortName: String?, city: String?, icon: String?, id : String?, distance: String?) {
        self.name = name
        self.categoryShortName = categoryShortName
        self.city = city
        self.icon = icon
        self.id = id
        self.distance = distance
    }
    
    init(name: String) {
        self.name = name
    }
    
}
