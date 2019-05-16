//
//  OpenAddressVC.swift
//  TimosTravel
//
//  Created by timofey makhlay on 5/15/19.
//  Copyright © 2019 Timofey Makhlay. All rights reserved.
//


import UIKit
import MapKit
import SnapKit
import CoreData

/// Class to open already saved addresses.
class OpenAddressVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UISearchBarDelegate {
    
    // Needed for CoreData
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    // The current Location.
    var location: Locations?
    
    // The map itself
    var mapView: MKMapView = MKMapView()
    
    // MARK: - Search
    fileprivate var searchController: UISearchController!
    fileprivate var localSearchRequest: MKLocalSearch.Request!
    fileprivate var localSearch: MKLocalSearch!
    fileprivate var localSearchResponse: MKLocalSearch.Response!
    
    // MARK: - Map variables
    fileprivate var annotation: MKAnnotation!
    fileprivate var locationManager: CLLocationManager!
    fileprivate var isCurrentLocation: Bool = false
    
    // MARK: - Activity Indicator
    fileprivate var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - UIViewController's methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Map Layout
        addMapToView()
        
        // Map settings
        mapView.delegate = self
        mapView.mapType = .hybrid
        
        activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
        activityIndicator.hidesWhenStopped = true
        self.view.addSubview(activityIndicator)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        activityIndicator.center = self.view.center
        
        // Load the current Location on map
        loadLocation()
    }
    
    /// Map Layout
    func addMapToView() {
        view.addSubview(mapView)
        mapView.snp.makeConstraints { (map) in
            map.bottom.left.right.top.equalToSuperview()
            
        }
    }
    
    /// Load the current Location on map
    func loadLocation() {
        let pointAnnotation = MKPointAnnotation()
        pointAnnotation.coordinate =  CLLocationCoordinate2D(latitude: location!.lat, longitude: location!.alt)
        pointAnnotation.title = location!.name
        let pinAnnotationView = MKPinAnnotationView(annotation: pointAnnotation, reuseIdentifier: nil)
        
        // Set the coordinates on the map.
        mapView.centerCoordinate = pointAnnotation.coordinate
        mapView.addAnnotation(pinAnnotationView.annotation!)
    }

    
    // MARK: - CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if !isCurrentLocation {
            return
        }
        
        isCurrentLocation = false
        
        let location = locations.last
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        self.mapView.setRegion(region, animated: true)
        
        if self.mapView.annotations.count != 0 {
            annotation = self.mapView.annotations[0]
            self.mapView.removeAnnotation(annotation)
        }
        
        let pointAnnotation = MKPointAnnotation()
        pointAnnotation.coordinate = location!.coordinate
        pointAnnotation.title = ""
        mapView.addAnnotation(pointAnnotation)
    }
    
}

