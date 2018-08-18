//
//  OnePlace Strctures.swift
//  AllHere
//
//  Created by Maria Susana Moline Venanzi on 4/1/18.
//  Copyright © 2018 HRApps. All rights reserved.
//

import Foundation

struct OnePlaceData: Codable {
    //let meta : Meta
    let response : ResponseOne
}




struct ResponseOne : Codable {
     let venue : VenueOne
}


struct VenueOne : Codable {
    //let id : String
    let name : String
    let contact : ContactOne?
    let location : LocationOne
    let bestPhoto : BestPhotoOne?
    let url : String?
    //let categories : [Categories]
}


struct BestPhotoOne : Codable {
    let prefix : String?
    let suffix : String?
}

struct LocationOne : Codable {
    let address : String?
    let city : String?
    let state : String?
    let postalCode : String?
    let country : String?
    let crossStreet : String?
}



struct ContactOne : Codable {
    let formattedPhone : String?
}

