//
//  Place Structure.swift
//  LL
//
//  Created by Maria Susana Moline Venanzi on 4/25/18.
//  Copyright © 2018 HRApps. All rights reserved.
//


import Foundation

struct PlacesData: Codable {
    let meta : Meta
    let response : Response
}

struct Meta : Codable {
    let code: Int
    let requestId : String
}

struct Response : Codable {
    let confident : Bool
    let venues : [Venues]
}

struct Venues : Codable {
    let id : String
    let name : String
    let categories : [Categories]
    let location : Location
}


struct Categories : Codable {
    let icon : Icon
    let shortName : String?
}

struct Location : Codable {
    let city : String?
    let distance: Int?
}


struct Icon : Codable {
    let prefix : String?
    let suffix : String?
}






