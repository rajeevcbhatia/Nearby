//
//  MapLocation.swift
//  Nearby
//
//  Created by Rajeev Bhatia on 15/05/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import Foundation
import MapKit

class MapAnnotation: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(title: String, subtitle: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
        
        super.init()
    }
    
    static func annotations(for venue: [Venue]) -> [MapAnnotation] {
        
        return venue.map { (venue) -> MapAnnotation in
            return MapAnnotation.init(title: venue.name, subtitle: venue.location.address, coordinate: venue.location.coordinate)
        }
        
    }
}
