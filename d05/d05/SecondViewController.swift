//
//  SecondViewController.swift
//  d05
//
//  Created by Clementine URQUIZAR on 3/22/19.
//  Copyright © 2019 Clementine URQUIZAR. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class SecondViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    let annotation = MKPointAnnotation()
    let regionRadius: CLLocationDistance = 1000
    var locationManager = CLLocationManager()
    
//    var location: CLLocation!
    
    @IBOutlet weak var mapView: MKMapView! {
        didSet {
            mapView.delegate = self
        }
    }

    @IBOutlet weak var segBar: UISegmentedControl!

    @IBAction func mapTypeSegmentBar(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
            case 0:
                mapView.mapType = .standard
            case 1:
                mapView.mapType = .satellite
            default:
                mapView.mapType = .hybrid
            }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mapView.showsUserLocation = true;
        setSegBarUI()
        set42Pin()
//        centerOn42School()
        setLocationManager()
        
//        let center = CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
//        centerMapOnLocation(location: center)
        
        
    }

    func set42Pin() {
        annotation.coordinate = CLLocationCoordinate2D(latitude: 48.896607, longitude: 2.3185009999999693)
        annotation.title = "Ecole 42"
        annotation.subtitle = "le QG"
        mapView.addAnnotation(annotation)
    }

    func setSegBarUI() {
        segBar.backgroundColor = .white
        segBar.layer.cornerRadius = 5
    }

    func centerOn42School() {
        let initialLocation = CLLocation(latitude: 48.896607, longitude: 2.3185009999999693)
        centerMapOnLocation(location: initialLocation)
    }

    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func setLocationManager() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.distanceFilter = 10
        locationManager.startUpdatingLocation()
    }

    @IBAction func centerButtonAction(_ sender: UIButton) {
        print("center button")
        if myLocation != nil {
            centerMapOnLocation(location: myLocation!)
        }
    }
    
    var myLocation: CLLocation?
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("update de ouf")
//        self.location = locations.last as! CLLocation
        myLocation = locations.last
    }
}

