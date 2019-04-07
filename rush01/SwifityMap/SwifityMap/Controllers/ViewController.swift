//
//  ViewController.swift
//  SwifityMap
//
//  Created by Felicien RENAUD on 4/5/19.
//  Copyright © 2019 Felicien RENAUD. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate, traceDelegate {

    @IBOutlet weak var mapView : MKMapView!
    @IBOutlet weak var segBar: UISegmentedControl!
    @IBOutlet weak var lockLabel: UILabel!
    @IBOutlet weak var itinareryButton: UIButton!
    
    let locationManager = CLLocationManager()
    var resultSearchController : UISearchController? = nil
    var selectedPin : MKPlacemark? = nil
    var userLocationLocked: Bool = false
    var userLocation: CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let locationSearchTable = storyboard!.instantiateViewController(withIdentifier: "LocationSearchTableViewController") as! LocationSearchTableViewController
        locationSearchTable.mapView = mapView
        locationSearchTable.handleMapSearchDelegate = self
        
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController?.searchResultsUpdater = locationSearchTable
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        resultSearchController?.dimsBackgroundDuringPresentation = true
        
        definesPresentationContext = true
        
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search"
        navigationItem.titleView = resultSearchController?.searchBar
        
        setSegBarUI()
        setItinareryButtonUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        unsetLockLabel()
    }

    /* Location manager protocol */
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            print("Updating location...")
            userLocation = location
            if userLocationLocked == true {
                centerOnLocation(locationCoordinate: location.coordinate)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error: \(error)")
    }
    
    /* Center on location */
    
    func centerOnLocation(locationCoordinate: CLLocationCoordinate2D) {
        print("Centering on location(lat: \(locationCoordinate.latitude), long: \(locationCoordinate.longitude))")
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: locationCoordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    /* SegBar */
    
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
    
    func setSegBarUI() {
        segBar.backgroundColor = .white
        segBar.layer.cornerRadius = 5
    }
    
    /* User Location */
    
    @IBAction func userLocationAction(_ sender: UIButton) {
        if userLocationLocked == false {
            print("User location locked")
            userLocationLocked = true
            guard let userLoc = userLocation else { return }
            centerOnLocation(locationCoordinate: userLoc.coordinate)
            lockLabel.text = "Locked"
            lockLabel.textColor = .red
        } else {
            print("User location unlocked")
            unsetLockLabel()
        }
    }
    
    func unsetLockLabel() {
        userLocationLocked = false
        lockLabel.text = ""
        lockLabel.textColor = .black
    }
    
    /* Itinarery Button */
    
    func setItinareryButtonUI() {
        let color = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        itinareryButton.layer.cornerRadius = 5
        itinareryButton.backgroundColor = .white
        itinareryButton.layer.borderColor = color.cgColor
        itinareryButton.layer.borderWidth = 1
        itinareryButton.contentEdgeInsets = UIEdgeInsetsMake(10,10,10,10)
        itinareryButton.tintColor = color
    }
    
    @IBAction func itinareryButtonAction(_ sender: UIButton) {
        print("Itinarery Button pressed")
        //itinarerySegue
        let itinareryViewController = self.storyboard?.instantiateViewController(withIdentifier: "itinareryViewController") as! ItinareryViewController
        definesPresentationContext = false
        itinareryViewController.traceDelegate = self
        self.navigationController?.pushViewController(itinareryViewController, animated: true)
    }
    
}

protocol HandleMapSearch {
    func dropPinZoomIn(placemark: MKPlacemark)
}

extension ViewController: HandleMapSearch {
    
    func dropPinZoomIn(placemark:MKPlacemark) {
        selectedPin = placemark
        mapView.removeAnnotations(mapView.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name
        if let city = placemark.locality,
            let state = placemark.administrativeArea {
            print("City: \(city), state: \(state)")
            annotation.subtitle = "\(city) \(state)"
        }
        mapView.addAnnotation(annotation)
        unsetLockLabel()
        centerOnLocation(locationCoordinate: placemark.coordinate)
    }
}

extension ViewController : MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?{
        if annotation is MKUserLocation {
            return nil
        }
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
        pinView?.pinTintColor = UIColor.red
        pinView?.canShowCallout = true
        let smallSquare = CGSize(width: 30, height: 30)
        let button = UIButton(frame: CGRect(origin: CGPoint(), size: smallSquare))
        button.setBackgroundImage(UIImage(named: "car"), for: [])
        button.addTarget(self, action: #selector(ViewController.getDirections), for: .touchUpInside)
        pinView?.leftCalloutAccessoryView = button
        return pinView
    }
    
    @objc func getDirections(){
        if let selectedPin = selectedPin {
            print("Ask for itinerary")
            guard let source = userLocation?.coordinate else { return }
            traceRoute(sourceLocation: source, destinationLocation: selectedPin.coordinate)
        }
    }
    
    func traceRoute(sourceLocation: CLLocationCoordinate2D, destinationLocation: CLLocationCoordinate2D) {
        mapView.delegate = self

        // Remove other traces
        let overlays = self.mapView.overlays
        self.mapView.removeOverlays(overlays)
        mapView.removeAnnotations(mapView.annotations)
        
        let sourcePlacemark = MKPlacemark(coordinate: sourceLocation, addressDictionary: nil)
        let destinationPlacemark = MKPlacemark(coordinate: destinationLocation, addressDictionary: nil)
        
        let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)

        let sourceAnnotation = MKPointAnnotation()
        sourceAnnotation.title = "Start"
        if let location = sourcePlacemark.location {
            sourceAnnotation.coordinate = location.coordinate
        }
        let destinationAnnotation = MKPointAnnotation()
        destinationAnnotation.title = "Arrival"
        if let location = destinationPlacemark.location {
            destinationAnnotation.coordinate = location.coordinate
        }
        
        self.mapView.showAnnotations([sourceAnnotation,destinationAnnotation], animated: true)
    
        let directionRequest = MKDirectionsRequest()
        directionRequest.source = sourceMapItem
        directionRequest.destination = destinationMapItem
        directionRequest.transportType = MKDirectionsTransportType(rawValue: MKDirectionsTransportType.RawValue(1 << 0)) // automobile
        
        // Calculate the direction
        let directions = MKDirections(request: directionRequest)
        
        
        
        directions.calculate {
            (response, error) -> Void in
            
            guard let response = response else {
                if let error = error {
                    print("Error: \(error)")
                    DispatchQueue.main.async {
                        self.launchAlert(str: "Impossible to trace your itinerary")
                    }
                }
                return
            }
            
            let route = response.routes[0]
            
            self.mapView.add((route.polyline), level: MKOverlayLevel.aboveRoads)

            var rect = route.polyline.boundingMapRect
            rect.size.height *= 1.2
            rect.size.width *= 1.2
            rect.origin.x -= (rect.size.width * 0.1)
            rect.origin.y -= (rect.size.height * 0.1)
            self.mapView.setRegion(MKCoordinateRegionForMapRect(rect), animated: true)
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.blue
        renderer.lineWidth = 4.0
        
        return renderer
    }
    
    func launchAlert(str: String) {
        let alert = UIAlertController(title: "An error occured", message: str, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("Alert : \(str)")
        }))
        self.present(alert, animated: true, completion: nil)
    }
}


protocol traceDelegate {
    func traceRoute(sourceLocation: CLLocationCoordinate2D, destinationLocation: CLLocationCoordinate2D)
}

