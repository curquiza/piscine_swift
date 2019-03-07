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
    var restart : Bool = true
    
    func debugLog(str: String) {
        print("Press " + str)
        print("New display = " + resultLabel.text!)
        print("Current op = " + currentOp)
        print("Result = " + String(rslt))
        print("----------------")
    }
    
    @IBAction func numbers(_ sender: UIButton) {
//        if (resultLabel.text == "0" || resultLabel.text == "+" || resultLabel.text == "-" || resultLabel.text == "/" || resultLabel.text == "*" || resultLabel.text == "Error") {
        if (restart == true) {
            resultLabel.text = sender.titleLabel?.text
        } else if (resultLabel.text!.count < 16) {
            resultLabel.text =  (resultLabel.text)! + (sender.titleLabel?.text)!
        }
        restart = false
        debugLog(str: (sender.titleLabel?.text)!)
    }

    @IBAction func buttonAC(_ sender: UIButton) {
        rslt = 0.0
        currentOp = ""
        restart = true
        resultLabel.text = "0"
        debugLog(str: "AC")
    }
    
    @IBAction func buttonNeg(_ sender: UIButton) {
        if ((resultLabel.text! as NSString).doubleValue != 0.0) {
            if (resultLabel.text!.hasPrefix("-")) {
                let range = resultLabel.text!.index(after: resultLabel.text!.startIndex)..<resultLabel.text!.endIndex
                resultLabel.text = String(resultLabel.text![range])
            } else {
                resultLabel.text = "-" + resultLabel.text!
            }
        }
        restart = false
        debugLog(str: "NEG")
    }
    
    func applyOps(buttonName : String, currentDisplay : Double) -> String {
        if (currentOp == "/" && currentDisplay == 0.0) {
            currentOp = ""
            rslt = 0.0
            return "Error"
        } else {
            switch buttonName {
            case "+":
                rslt += currentDisplay
            case "-":
                rslt -= currentDisplay
            case "*":
                rslt *= currentDisplay
            case "/":
                rslt /= currentDisplay
            default:
                rslt = currentDisplay
            }
            return String(rslt)
        }
    }
    
    func cleanDisplay(toDisplay: String) -> String {
        if (toDisplay == "-0.0") {
            return "0.0"
        } else {
            return toDisplay
        }
    }
    
    @IBAction func ops(_ sender: UIButton) {
        let buttonName : String = (sender.titleLabel?.text)!
        let toDisplay = applyOps(buttonName: currentOp, currentDisplay: (resultLabel.text! as NSString).doubleValue)
        if (toDisplay == "Error") {
            resultLabel.text = cleanDisplay(toDisplay: toDisplay)
        } else {
            resultLabel.text = buttonName
        }
        currentOp = buttonName
        restart = true
        debugLog(str: buttonName)
    }
    
    @IBAction func buttonEqual(_ sender: UIButton) {
        let toDisplay : String = applyOps(buttonName: currentOp, currentDisplay: (resultLabel.text! as NSString).doubleValue)
        resultLabel.text = cleanDisplay(toDisplay: toDisplay)
        currentOp = ""
        restart = true
        debugLog(str: "Equal")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

