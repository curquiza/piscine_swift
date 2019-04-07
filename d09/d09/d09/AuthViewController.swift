//
//  AuthViewController.swift
//  d09
//
//  Created by Clementine URQUIZAR on 4/5/19.
//  Copyright © 2019 Clementine URQUIZAR. All rights reserved.
//

import UIKit
import LocalAuthentication

class AuthViewController: UIViewController {
    
    let authContext = LAContext()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Authentification view loaded")
        
        if authContext.canEvaluatePolicy(.deviceOwnerAuthentication, error: nil) {
            authContext.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: "You need to be authenticate") {
                (success, error) in
                if success {
                    print(success)
                    
                    print("Success authentification")
                    DispatchQueue.main.async {
                        let articlesViewController = self.storyboard?.instantiateViewController(withIdentifier: "articlesViewController") as! ArticlesViewController
                        self.navigationController?.pushViewController(articlesViewController, animated: true)
                    }
                } else {
                    print("ERROR:")
                    if let e = error as? LAError {
                        switch e.code {
                        case LAError.authenticationFailed:
                            print("authenticationFailed error !")
                        case LAError.userCancel:
                            print("userCancel error !")
                        default:
                            break
                        }
                    }
                }
                
            }
        }
    }
    
}
