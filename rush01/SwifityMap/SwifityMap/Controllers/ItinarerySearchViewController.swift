//
//  ItinarerySearchViewController.swift
//  SwifityMap
//
//  Created by Clementine URQUIZAR on 4/6/19.
//  Copyright © 2019 Felicien RENAUD. All rights reserved.
//

import UIKit
import MapKit

class ItinarerySearchViewController: UIViewController {
    
    
    var resultSearchController: UISearchController?
    var locationSearchTable: LocationSearchTableViewController?
    var destType: String?
    var saveItinareryDelegate: saveItinareryValueDelegate?
    
    var mapItem: MKPlacemark? {
        didSet {
            print("MapItem didset (for itinarery)")
            self.saveItinareryDelegate?.saveValue(destType: destType, mapItem: mapItem)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    override func viewDidLoad() {

        locationSearchTable = (storyboard!.instantiateViewController(withIdentifier: "LocationSearchTableViewController") as! LocationSearchTableViewController)
        locationSearchTable?.itinarerySearchDelegate = self
        locationSearchTable!.itinaryIsPreviousView = true
        
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController?.searchResultsUpdater = locationSearchTable
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        resultSearchController?.dimsBackgroundDuringPresentation = true
        
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search"
        navigationItem.titleView = resultSearchController?.searchBar
        
        definesPresentationContext = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        definesPresentationContext = false
    }

}

protocol ItinarerySearchDelegate {
    func processMapItem(placemark: MKPlacemark)
}

extension ItinarerySearchViewController: ItinarerySearchDelegate {
    func processMapItem(placemark: MKPlacemark) {
        self.mapItem = placemark
    }
    
}
