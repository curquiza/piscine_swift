//
//  FirstViewController.swift
//  d05
//
//  Created by Clementine URQUIZAR on 3/22/19.
//  Copyright © 2019 Clementine URQUIZAR. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tabBar: UITabBarItem!
    
    @IBOutlet weak var placesTableView: UITableView! {
        didSet {
            placesTableView.delegate = self
            placesTableView.dataSource = self
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Pressing place cell")
        if let secondView = self.tabBarController?.viewControllers![1] as? SecondViewController {
            secondView.currentPlace = Places[indexPath.row]
        }
        self.tabBarController?.selectedIndex = 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("first view loaded")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "placeCell", for: indexPath)
        cell.textLabel?.text = Places[indexPath.row].title
        return cell
    }

}

