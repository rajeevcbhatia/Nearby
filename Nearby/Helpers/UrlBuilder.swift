//
//  UrlBuilder.swift
//  Nearby
//
//  Created by Rajeev Bhatia on 21/05/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import Foundation

enum UrlBuilder {
    
    case searchVenue(latitude: Double, longitude: Double)
    
    var path: String {
        
        switch self {
            
        case .searchVenue(latitude: let latitude, longitude: let longitude):
            
        let searchUrlString = urlString(with: UrlBase.search, specifiers: [
                (UrlParams.clientId, UrlValues.clientId.rawValue),
                (UrlParams.clientSecret, UrlValues.clientSecret.rawValue),
                (UrlParams.scenario, UrlValues.browse.rawValue),
                (UrlParams.categoryId, UrlValues.restaurantCategoryId.rawValue),
                (UrlParams.version, UrlValues.version),
                (UrlParams.coordinate, "\(latitude),\(longitude)"),
                (UrlParams.radius, UrlValues.radius.rawValue)])
        
            return searchUrlString
        }
    }
    
    private func urlString(with endpoint: UrlBase, specifiers: [UrlSpecifier]) -> String {
        
        var urlString = "\(UrlBase.base.rawValue)/\(endpoint)"
        for (index, specifier) in specifiers.enumerated() {
            
            let joiner =  index == 0 ? "?" : "&"
            urlString += "\(joiner)\(specifier.param.rawValue)=\(specifier.value)"
            
        }
        
        return urlString
        
    }
}

typealias UrlSpecifier = (param: UrlParams, value: String)
