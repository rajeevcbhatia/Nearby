//
//  MapViewController.swift
//  Nearby
//
//  Created by Rajeev Bhatia on 18/05/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: BaseViewController {

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
            mapView.isZoomEnabled = false
            
            fetchVenuesForCurrentCenter()
        }
    }
    
    @IBOutlet weak var searchHereButton: UIButton! {
        didSet {
            searchHereButton.accessibilityIdentifier = Identifier.searchHereButton.rawValue
        }
    }
    
    @IBAction func searchHereAction(_ sender: Any) {
        searchHereButton.isHidden = true
        fetchVenuesForCurrentCenter()
    }
    
    private let service: Service
    private let startLocation = CLLocationCoordinate2D(latitude: CLLocationDegrees(52.374399), longitude: CLLocationDegrees(4.891726))
    
    init(service: Service) {
        self.service = service
        super.init(nibName: String(describing: MapViewController.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func showAnnotations(venues: [Venue]) {
        DispatchQueue.main.async { [weak self] in
            self?.mapView.removeAnnotations(self?.mapView.annotations ?? [])
            self?.mapView.addAnnotations(MapAnnotation.annotations(for: venues))
        }
    }
    
    private func fetchVenuesForCurrentCenter() {
        self.showLoader()
        
        service.fetchVenues(latitude: mapView.centerCoordinate.latitude,longitude: mapView.centerCoordinate.longitude) { [weak self] (result) in
            guard let strongSelf = self else { return }
            strongSelf.hideLoader()
            
            guard let venues = try? result.get() else {
                // TODO:- show error
                DispatchQueue.main.async {
                    strongSelf.searchHereButton.isHidden = false
                }
                
                return
            }
            
            strongSelf.venuesForCurrentRegion = venues
        }
    }
    
    private func showDetail(for venue: Venue) {
        
    }
    
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        mapView.deselectAnnotation(view.annotation, animated: true)
        
        guard let mapAnnotation = view.annotation as? MapAnnotation, let currentVenue = venuesForCurrentRegion.first(where: { (venue) -> Bool in
            return venue.id == mapAnnotation.id
        }) else { return }
        
        showDetail(for: currentVenue)
    }
    
    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
        searchHereButton.isHidden = false
    }
    
}

typealias Edges = (ne: CLLocationCoordinate2D, sw: CLLocationCoordinate2D)

private extension MKMapView {
    func edgePoints() -> Edges {
        let nePoint = CGPoint(x: self.bounds.maxX, y: self.bounds.origin.y)
        let swPoint = CGPoint(x: self.bounds.minX, y: self.bounds.maxY)
        let neCoord = self.convert(nePoint, toCoordinateFrom: self)
        let swCoord = self.convert(swPoint, toCoordinateFrom: self)
        return (ne: neCoord, sw: swCoord)
    }
}
