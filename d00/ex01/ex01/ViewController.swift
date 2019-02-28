//
//  ViewController.swift
//  ex01
//
//  Created by Clementine URQUIZAR on 2/28/19.
//  Copyright © 2019 Clementine URQUIZAR. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var cocoLabel: UILabel!
    
    @IBAction func clickMeButton(_ sender: UIButton) {
        print("Hello World !")
        cocoLabel.text = "Hello World !"
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

