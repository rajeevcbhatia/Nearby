//
//  NetworkService.swift
//  Nearby
//
//  Created by Rajeev Bhatia on 18/05/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import Foundation
import MapKit

class NetworkService: Service {
    
    static let shared = NetworkService()
    
    private init() {}
    
    func fetchVenues(latitude: Double, longitude: Double,completion: @escaping (Result<[Venue], ConnectionError>) -> Void) {
        
        let urlString = UrlBuilder.searchVenue(latitude: latitude, longitude: longitude).path
        
        guard let url = URL(string: urlString) else {
            completion(.failure(ConnectionError.couldNotGetDetails))
            return
        }
        
        let request = URLRequest(url: url)
        let session = URLSession(configuration:URLSessionConfiguration.default)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let responseData = data, let root: Root = ServiceHelper.decode(data: responseData) else {
                completion(.failure(ConnectionError.couldNotGetDetails))
                return
            }
            completion(.success(root.response.venues))
        }
        task.resume()
    }
    
    
}
