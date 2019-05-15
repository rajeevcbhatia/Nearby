//
//  Model.swift
//  Nearby
//
//  Created by Rajeev Bhatia on 15/05/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import Foundation

struct Root: Codable {
    let response: Response
}

struct Response: Codable {
    let venues: [Venue]
}

struct Venue: Codable {
    let id, name: String
    let location: Location
    
    enum CodingKeys: String, CodingKey {
        case id, name, location
    }
}

struct Location: Codable {
    let address: String
    let lat, lng: Double
}

//let root = try JSONDecoder().decode(Root.self, from: data)
//print(root.response.venues)