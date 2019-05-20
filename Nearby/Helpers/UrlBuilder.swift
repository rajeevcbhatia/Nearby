//
//  UrlBuilder.swift
//  Nearby
//
//  Created by Rajeev Bhatia on 21/05/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import Foundation

enum UrlBuilder {
    
    case searchVenue(version: String, latitude: Double, longitude: Double)
    
    var path: String {
        
        let base = "https://api.foursquare.com/v2/venues"
        let clientSecret = "ED3CGJUY1PITOSOBLENAQBJB1TEBD5CGQORLKKOO5WXRLREO"
        let clientId = "KOGEX4EPMA3OBMOUIJGP22CBCXJVQ1BRLH3W5GLDBB0C2C4L"
        
        switch self {
            
        case .searchVenue(version: let version, latitude: let latitude, longitude: let longitude):
            
            return "\(base)/search?client_id=\(clientId)&client_secret=\(clientSecret)&scenario=browse&categoryId=4d4b7105d754a06374d81259&v=\(version)&ll=\(latitude),\(longitude)&radius=4000"
            
        }
    }
}
