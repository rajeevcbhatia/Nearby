//
//  Service.swift
//  Nearby
//
//  Created by Rajeev Bhatia on 15/05/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import Foundation
import MapKit

protocol Service {
    func fetchVenues(latitude: Double, longitude: Double, completion: @escaping (Result<[Venue], ConnectionError>) -> Void)
}

enum ConnectionError: Error {
    case couldNotGetDetails
}

class ServiceHelper {
    
    static func decode<T: Codable>(data: Data) -> T? {
        
        let decoder = JSONDecoder()
        let result = try? decoder.decode(T.self, from: data)
        return result
        
    }
}
