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
    
    func debugLog(str: String) {
        print("Press " + str)
        print("New display = " + resultLabel.text!)
        print("Result = " + String(rslt))
        print("----------------")
    }
    
    @IBAction func numbers(_ sender: UIButton) {
        if (resultLabel.text == "0" || resultLabel.text == "+" || resultLabel.text == "-" || resultLabel.text == "/" || resultLabel.text == "*") {
            resultLabel.text = sender.titleLabel?.text
        } else if (resultLabel.text!.count < 16) {
            resultLabel.text =  (resultLabel.text)! + (sender.titleLabel?.text)!
        }
        debugLog(str: (sender.titleLabel?.text)!)
    }

    @IBAction func buttonAC(_ sender: UIButton) {
        rslt = 0.0
        currentOp = ""
        resultLabel.text = "0"
        debugLog(str: "AC")
    }
    
    @IBAction func buttonNeg(_ sender: UIButton) {
        if (resultLabel.text!.hasPrefix("-")) {
            let range = resultLabel.text!.index(after: resultLabel.text!.startIndex)..<resultLabel.text!.endIndex
            resultLabel.text = String(resultLabel.text![range])
        } else {
            resultLabel.text = "-" + resultLabel.text!
        }
        debugLog(str: "NEG")
    }
    
    @IBAction func buttonPlus(_ sender: UIButton) {
//        if (currentOp != "") {
////            //appliquer comme pour = mais sans afficher le result
//        } else {
            rslt += (resultLabel.text! as NSString).doubleValue
            resultLabel.text = "+"
            currentOp = "+"
//        }
        debugLog(str: "+")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

