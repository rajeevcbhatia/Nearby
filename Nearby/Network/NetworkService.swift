//
//  NetworkService.swift
//  Nearby
//
//  Created by Rajeev Bhatia on 18/05/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import Foundation

class NetworkService: Service {
    
    static let shared = NetworkService()
    
    private init() {}
    
    func fetchVenues(latitude: Double, longitude: Double, completion: @escaping (Result<[Venue], ConnectionError>) -> Void) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYYMMDD"
        let versionString = dateFormatter.string(from: Date())
        
        let urlString = "https://api.foursquare.com/v2/venues/search?client_id=KOGEX4EPMA3OBMOUIJGP22CBCXJVQ1BRLH3W5GLDBB0C2C4L&client_secret=ED3CGJUY1PITOSOBLENAQBJB1TEBD5CGQORLKKOO5WXRLREO&ll=\(latitude),\(longitude)&scenario=browse&categoryId=4d4b7105d754a06374d81259&v=\(versionString)&radius=5000"
        
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
