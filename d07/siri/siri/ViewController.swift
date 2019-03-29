//
//  ViewController.swift
//  siri
//
//  Created by Clementine URQUIZAR on 3/29/19.
//  Copyright © 2019 Clementine URQUIZAR. All rights reserved.
//

import UIKit
import ForecastIO
import sapcai


class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var responseLabel: UILabel!
    @IBOutlet weak var requestButton: UIButton!
    
    var botRecast: SapcaiClient?
    var darkskyClient: DarkSkyClient?
    
    let mainColor = #colorLiteral(red: 0.3669775426, green: 0.5502967238, blue: 1, alpha: 1)

    @IBAction func requestButtonAction(_ sender: UIButton) {
        let text = textField.text!
        print("Request = \(text)")
        botRecast?.converseText(text, successHandler: recastSuccessHandler, failureHandle: recastErrorHandler)
    }
    
    func recastSuccessHandler(res: ConverseResponse) {
        print("RecastSuccessHandler")
        if let loc = res.entities?.locations?.first {
            let lat = loc.lat
            let long = loc.lng
            print("Intention -> Location: \(loc.raw) ; Lat: \(lat) ; Long: \(long)")
            darkskyClient?.getForecast(latitude: Double(lat), longitude: Double(long), completion: {
                (response) in
                print("Darksky is answering...")
                switch response {
                case .failure(let e):
                    print(e)
                    DispatchQueue.main.async {
                        self.launchAlert(str: "Impossible to catch weather information")
                        self.responseLabel.text = "Error"
                    }
                case .success(let currentForecast, _):
                    if let res = currentForecast.currently?.summary {
                        print("DarkSky summary response : \(res)")
                        DispatchQueue.main.async {
                            self.responseLabel.text = res
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.launchAlert(str: "Impossible to catch weather information")
                            self.responseLabel.text = "Error"
                        }
                    }
                }
            })
        } else {
            launchAlert(str: "Impossible to understand the intention")
            responseLabel.text = "Error"
        }
    }
    
    func recastErrorHandler(e: Error){
        print("RecastErrorHandler")
        responseLabel.text = "Error"
        launchAlert(str: e.localizedDescription)
    }
    
    func launchAlert(str: String) {
        let alert = UIAlertController(title: "An error occured", message: str, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("Alert : \(str)")
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Init tokens (Sapcai and Darksky)
        if let recastToken = ProcessInfo.processInfo.environment["RECAST_TOKEN"] {
            botRecast = SapcaiClient(token: recastToken)
        } else {
            responseLabel.text = "Token error"
        }
        if let darkskyToken = ProcessInfo.processInfo.environment["DARKSKY_TOKEN"] {
            darkskyClient = DarkSkyClient(apiKey: darkskyToken)
        } else {
            responseLabel.text = "Token error"
        }
        
        // CSS de ouf
        textField.layer.borderColor = mainColor.cgColor;
        textField.textColor = mainColor
        textField.minimumFontSize = 20
        textField.layer.borderWidth = 2.0
        textField.layer.cornerRadius = 8.0
        textField.font = UIFont.boldSystemFont(ofSize: 16)
        requestButton.backgroundColor = mainColor
        requestButton.tintColor = .white
        requestButton.layer.cornerRadius = 9.0
        requestButton.contentEdgeInsets = UIEdgeInsetsMake(10,10,10,10)
        title = "Siri"
    }
    
}

