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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
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
                
                DispatchQueue.main.async {
                    strongSelf.showAlert(title: "Could not load venues", message: "Please try again")
                    strongSelf.searchHereButton.isHidden = false
                }
                
                return
            }
            
            strongSelf.venuesForCurrentRegion = venues
        }
    }
    
    private func showDetail(for venue: Venue) {
        let detailVC = DetailViewController(venue: venue)
        navigationController?.pushViewController(detailVC, animated: true)
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
