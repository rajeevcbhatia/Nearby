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
    var id: String
    
    init(id: String, title: String, subtitle: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
        self.id = id
        super.init()
    }
    
    static func annotations(for venue: [Venue]) -> [MapAnnotation] {
        
        return venue.map { (venue) -> MapAnnotation in
            return MapAnnotation.init(id: venue.id, title: venue.name, subtitle: venue.location.address, coordinate: venue.location.coordinate)
        }
        
    }
}
