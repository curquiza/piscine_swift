//
//  ViewController.swift
//  death-note
//
//  Created by Clementine URQUIZAR on 3/8/19.
//  Copyright © 2019 Clementine URQUIZAR. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var deathTableView: UITableView! {
        didSet {
            deathTableView.delegate = self
            deathTableView.dataSource = self
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Data.deathNotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell") as! DeathNoteTableViewCell
        cell.note = Data.deathNotes[indexPath.row]
//        cell?.textLabel?.text = Data.deathNotes[indexPath.row].name
//        cell?.detailTextLabel?.text = Data.deathNotes[indexPath.row].description
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("Segue :", segue.identifier!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

