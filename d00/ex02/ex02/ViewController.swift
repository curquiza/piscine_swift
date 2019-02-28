//
//  ViewController.swift
//  ex02
//
//  Created by Clementine URQUIZAR on 2/28/19.
//  Copyright © 2019 Clementine URQUIZAR. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var resultLabel: UILabel!
    
    var rslt : Double = 0.0
    var currentOp : String = ""
    
    @IBAction func numbers(_ sender: UIButton) {
        //        print(sender.titleLabel?.text!)
        if (resultLabel.text == "0" || resultLabel.text == "+" || resultLabel.text == "-" || resultLabel.text == "/" || resultLabel.text == "*") {
            resultLabel.text = sender.titleLabel?.text
        } else if (resultLabel.text!.count < 16) {
            resultLabel.text =  (resultLabel.text)! + (sender.titleLabel?.text)!
        }
        print("Press " + (sender.titleLabel?.text)!)
        print("New display = " + resultLabel.text!)
    }

    @IBAction func buttonAC(_ sender: UIButton) {
        rslt = 0.0
        currentOp = ""
        resultLabel.text = "0"
        print("Press Reset")
    }
    
    @IBAction func buttonNeg(_ sender: UIButton) {
        resultLabel.text = "-" + resultLabel.text!
        print("Press Neg")
//        rslt = Double!("-" + resultLabel.text!)
    }
    
//    @IBAction func buttonPlus(_ sender: UIButton) {
//        if (currentOp != "") {
//            //appliquer comme pour = mais sans afficher le result
//        } else {
//            rslt = Double!(resultLabel.text?)
//            resultLabel.text = "+"
//            currentOp = "+"
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

