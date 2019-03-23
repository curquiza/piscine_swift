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

class MyPointAnnotation : MKPointAnnotation {
    var color: UIColor?
}

class SecondViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    var locationManager = CLLocationManager()
    var userLocation: CLLocation?
    
    var currentPlace: Place? = nil

    
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
    
    override func viewWillAppear(_ animated: Bool) {
        print("second view appeared")
        if currentPlace != nil {
            self.centerMapOnPin(pin: currentPlace!)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("second view loaded")
        // Map types
        setSegBarUI()
        
        // Pins init
//        set42Pin()
//        centerOn42School()
        createAllPins()
        
        // set user location
        setLocationManager()
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    
        if annotation.isEqual(mapView.userLocation) {
            return nil
        }
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "myAnnotation") as? MKPinAnnotationView

        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "myAnnotation")
            annotationView!.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }
        
        if let annotation = annotation as? MyPointAnnotation {
            annotationView?.pinTintColor = annotation.color
        }
    
        return annotationView
    }
    
    
    func setSegBarUI() {
        segBar.backgroundColor = .white
        segBar.layer.cornerRadius = 5
    }
    
//    var annotations: [MKPointAnnotation] = []
    func createAllPins() {
        for place in Places {
//            let pin: MKPointAnnotation = MKPointAnnotation()
            let pin = MyPointAnnotation()
            pin.coordinate = CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)
            pin.title = place.title
            pin.subtitle = place.subtitle
            pin.color = getColor(colorStr: place.color)
            self.mapView.addAnnotation(pin)
            
//            annotations.append(pin)
        }
        // self.mapView.addAnnotations(annotations)
    }
    
    func getColor(colorStr: String) -> UIColor {
        switch colorStr {
        case "blue":
            return .blue
        case "green":
            return .green
        default:
            return .red
        }
    }
    
    func centerMapOnPin(pin: Place) {
        let initialLocation = CLLocation(latitude: pin.latitude, longitude: pin.longitude)
        centerMapOnLocation(location: initialLocation)
    }

//    let annotation = MKPointAnnotation()
//    func set42Pin() {
//        if let ecole42Place = Places.first(where: { $0.title == "Ecole 42" }) {
//            self.annotation.coordinate = CLLocationCoordinate2D(latitude: ecole42Place.latitude, longitude: ecole42Place.longitude)
//            self.annotation.title = ecole42Place.title
//            self.annotation.subtitle = ecole42Place.subtitle
//            self.mapView.addAnnotation(self.annotation)
//        }
//    }

//    func centerOn42School() {
//        if let ecole42Place = Places.first(where: { $0.title == "Ecole 42" }) {
//            let initialLocation = CLLocation(latitude: ecole42Place.latitude, longitude: ecole42Place.longitude)
//            centerMapOnLocation(location: initialLocation)
//        }
//    }

    func centerMapOnLocation(location: CLLocation) {
        let regionRadius: CLLocationDistance = 1000
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func setLocationManager() {
        self.mapView.showsUserLocation = true;
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.distanceFilter = 10
        locationManager.startUpdatingLocation()
    }

    @IBAction func centerButtonAction(_ sender: UIButton) {
        print("Pressing center button")
        if userLocation != nil {
            centerMapOnLocation(location: userLocation!)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("User location updated")
        userLocation = locations.last
    }
}

