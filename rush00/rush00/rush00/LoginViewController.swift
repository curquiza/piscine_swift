//
//  ViewController.swift
//  rush00
//
//  Created by Clementine URQUIZAR on 3/29/19.
//  Copyright © 2019 Clementine URQUIZAR. All rights reserved.
//

import UIKit

//enum NoTokenError: Error {
//    case message(String)
//}

class LoginViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    
    let mainColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // CSS
        loginButton.backgroundColor = mainColor
        loginButton.tintColor = .white
        loginButton.layer.cornerRadius = 9.0
        loginButton.contentEdgeInsets = UIEdgeInsetsMake(10,10,10,10)
        loginButton.setTitle("LOGIN", for: .normal)
 
    }

    
}

