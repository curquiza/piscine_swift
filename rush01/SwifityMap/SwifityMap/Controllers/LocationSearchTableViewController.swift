//
//  LocationSearchTableViewController.swift
//  SwifityMap
//
//  Created by Felicien RENAUD on 4/5/19.
//  Copyright © 2019 Felicien RENAUD. All rights reserved.
//

import UIKit
import MapKit

class LocationSearchTableViewController: UITableViewController, UISearchResultsUpdating {

    var matchingItems : [MKMapItem] = []
    var mapView : MKMapView?
    var handleMapSearchDelegate : HandleMapSearch? = nil
    var itinarerySearchDelegate: ItinarerySearchDelegate? = nil
    var itinaryIsPreviousView: Bool = false
    
    override func viewDidLoad() {
        print("LocationSearchTableViewController")
        super.viewDidLoad()
    }

    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchBarText = searchController.searchBar.text else { return }
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = searchBarText
//        guard let mapView = mapView else { return }
//        request.region = mapView.region // Permet de focaliser les recherches uniquement dans la région
        let search = MKLocalSearch(request: request)
        search.start(completionHandler: { ( response, _) in
            guard let response = response else { return }
//            print("Got response : \(response)")
            self.matchingItems = response.mapItems
            self.tableView.reloadData()
        })
    }
    
    func parseAddress(selectedItem:MKPlacemark) -> String {
        // put a space between "4" and "Melrose Place"
        let firstSpace = (selectedItem.subThoroughfare != nil && selectedItem.thoroughfare != nil) ? " " : ""
        // put a comma between street and city/state
        let comma = (selectedItem.subThoroughfare != nil || selectedItem.thoroughfare != nil) && (selectedItem.subAdministrativeArea != nil || selectedItem.administrativeArea != nil) ? ", " : ""
        // put a space between "Washington" and "DC"
        let secondSpace = (selectedItem.subAdministrativeArea != nil && selectedItem.administrativeArea != nil) ? " " : ""
        let addressLine = String(
            format:"%@%@%@%@%@%@%@",
            // street number
            selectedItem.subThoroughfare ?? "",
            firstSpace,
            // street name
            selectedItem.thoroughfare ?? "",
            comma,
            // city
            selectedItem.locality ?? "",
            secondSpace,
            // state
            selectedItem.administrativeArea ?? ""
        )
        return addressLine
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        let selectedItem = matchingItems[indexPath.row].placemark
        cell?.textLabel?.text = selectedItem.name
        cell?.detailTextLabel?.text = parseAddress(selectedItem: selectedItem)
        return cell!
    }
  

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchingItems.count
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        let selectedItem = matchingItems[indexPath.row].placemark
        if itinaryIsPreviousView == false {
            handleMapSearchDelegate?.dropPinZoomIn(placemark: selectedItem)
        } else  {
            itinarerySearchDelegate?.processMapItem(placemark: selectedItem)
        }
        dismiss(animated: true, completion: nil)
    }
    
}

