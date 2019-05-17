//
//  StartViewController.swift
//  Nearby
//
//  Created by Rajeev Bhatia on 15/05/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import UIKit
import MapKit
class StartViewController: BaseViewController {
    
    var venuesForCurrentRegion = [Venue]() {
        didSet {
            showAnnotations(venues: venuesForCurrentRegion)
        }
    }

    @IBOutlet weak var mapView: MKMapView! {
        didSet {
            let coordinateRegion = MKCoordinateRegion(center: startLocation, latitudinalMeters: CLLocationDistance(integerLiteral: 5000), longitudinalMeters: CLLocationDistance(integerLiteral: 5000))
            mapView.setRegion(coordinateRegion, animated: true)
            mapView.delegate = self
        }
    }
    
    private let service: Service
    private let startLocation = CLLocationCoordinate2D(latitude: CLLocationDegrees(52.374399), longitude: CLLocationDegrees(4.891726))
    
    init(service: Service) {
        self.service = service
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        service = NetworkService.shared
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchVenuesForCurrentCenter()
    }
    
    private func showAnnotations(venues: [Venue]) {
        DispatchQueue.main.async { [weak self] in
            self?.mapView.removeAnnotations(self?.mapView.annotations ?? [])
            self?.mapView.addAnnotations(MapAnnotation.annotations(for: venues))
        }
    }
    
    private func fetchVenuesForCurrentCenter() {
        self.showLoader()
        
        let coordinate = mapView.centerCoordinate
        
        service.fetchVenues(latitude: coordinate.latitude, longitude: coordinate.longitude) { [weak self] (result) in
            guard let strongSelf = self else { return }
            strongSelf.hideLoader()
            
            guard let venues = try? result.get() else {
                // TODO:- show error
                return
            }
            
            strongSelf.venuesForCurrentRegion = venues
        }
    }
    
    private func showDetail(for venue: Venue) {
        
    }
    
}

extension StartViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        mapView.deselectAnnotation(view.annotation, animated: true)
        
        guard let mapAnnotation = view.annotation as? MapAnnotation, let currentVenue = venuesForCurrentRegion.first(where: { (venue) -> Bool in
            return venue.id == mapAnnotation.id
        }) else { return }
        
        showDetail(for: currentVenue)
    }
}
