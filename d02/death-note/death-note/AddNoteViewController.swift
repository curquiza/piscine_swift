//
//  AddNoteViewController.swift
//  death-note
//
//  Created by Clementine URQUIZAR on 3/8/19.
//  Copyright © 2019 Clementine URQUIZAR. All rights reserved.
//

import UIKit

class AddNoteViewController: UIViewController {
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var descriptionField: UITextView!
    
    @IBAction func doneButton(_ sender: UIBarButtonItem) {
        print("Name field :", nameField.text!)
        print("Date picker field :", datePicker.date)
        print("Description field :", descriptionField.text!)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        descriptionField!.layer.borderWidth = 1
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
