//
//  DetailViewController.swift
//  Nearby
//
//  Created by Rajeev Bhatia on 20/05/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: UIViewController {
    
    private let venue: Venue

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBAction func actionGetDirections(_ sender: Any) {
        let destination = MKMapItem(placemark: MKPlacemark(coordinate: venue.location.coordinate))
        destination.name = venue.name
        
        MKMapItem.openMaps(with: [destination], launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
    }
    init(venue: Venue) {
        self.venue = venue
        super.init(nibName: String(describing: DetailViewController.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUIFromVenue()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    private func setUIFromVenue() {
        title = venue.name
        addressLabel.text = venue.location.formattedAddress.joined(separator: "\n")
        
        let coordinateRegion = MKCoordinateRegion(center: venue.location.coordinate, latitudinalMeters: CLLocationDistance(integerLiteral: 5000), longitudinalMeters: CLLocationDistance(integerLiteral: 5000))
        mapView.setRegion(coordinateRegion, animated: true)
        mapView.isUserInteractionEnabled = false
        mapView.addAnnotations(MapAnnotation.annotations(for: [venue]))
    }
}
