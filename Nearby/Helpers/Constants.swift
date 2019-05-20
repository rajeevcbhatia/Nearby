//
//  Constants.swift
//  Nearby
//
//  Created by Rajeev Bhatia on 21/05/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import Foundation

enum UrlBase: String {
    case base = "https://api.foursquare.com/v2/venues"
    case search = "/search"
}

enum UrlParams: String {
    case clientId = "client_id"
    case clientSecret = "client_secret"
    case version = "v"
    case coordinate = "ll"
    case categoryId = "categoryId"
    case radius = "radius"
    case scenario = "scenario"
}

enum UrlValues: String {
    case browse = "browse"
    case radius = "4000"
    case clientSecret = "ED3CGJUY1PITOSOBLENAQBJB1TEBD5CGQORLKKOO5WXRLREO"
    case clientId = "KOGEX4EPMA3OBMOUIJGP22CBCXJVQ1BRLH3W5GLDBB0C2C4L"
    case restaurantCategoryId = "4d4b7105d754a06374d81259"
    
    static var version: String {
        return DateFormatter().version
    }
}


private extension DateFormatter {
    var version: String {
        dateFormat = "YYYYMMDD"
        return string(from: Date())
    }
}
