//
//  CollectionViewCell.swift
//  d03
//
//  Created by Clementine URQUIZAR on 3/21/19.
//  Copyright © 2019 Clementine URQUIZAR. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var imageView: UIImageView!
    
    let queue = DispatchQueue.global(qos: DispatchQoS.background.qosClass)
    let main = DispatchQueue.main
    var fetch: Bool = false
    
    func displayContent(strURL: String) {
        if self.fetch == false {
            self.spinner.startAnimating()
            self.spinner.hidesWhenStopped = true
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            print(strURL)
            self.queue.async {
                let image = self.urlToUIImage(stringURL: strURL)
                self.main.async {
                    if image == nil {
                        self.spinner.stopAnimating()
                        self.imageView.backgroundColor = .black
                        self.launchAlert(str: "Impossible to fetch photo")
                    } else {
                        self.imageView.image = image
                        self.imageView.contentMode = UIViewContentMode.scaleAspectFit
                    }
                    self.spinner.stopAnimating()
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
            }
            self.fetch = true
        }
    }
    
    func urlToUIImage(stringURL: String) -> UIImage? {
        let imageURL = URL(string: stringURL)!
        if let imageData: NSData = NSData(contentsOf: imageURL) {
            return UIImage(data: imageData as Data)
        }
        return nil
    }
    
    func launchAlert(str: String) {
        let alert = UIAlertController(title: "An error occured", message: str, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("Alert : \(str)")
        }))
        self.window?.rootViewController?.present(alert, animated: true, completion: nil)
    }

}
