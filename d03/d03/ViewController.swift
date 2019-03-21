//
//  ViewController.swift
//  d03
//
//  Created by Clementine URQUIZAR on 3/21/19.
//  Copyright © 2019 Clementine URQUIZAR. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

//    let queue = DispatchQueue.global(qos: DispatchQoS.background.qosClass)
//    let main = DispatchQueue.main
//    var isAlert: Bool = false
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! CollectionViewCell
        
//        let qos = DispatchQoS.background.qosClass
//        let queue = DispatchQueue.global(qos: qos)
//        let main = DispatchQueue.main
        
//        self.queue.async {
//            let image = self.urlToUIImage(stringURL: Photos[indexPath.row].url)
//            self.main.async {
//                if image == nil {
//                    print(Photos[indexPath.row].title)
////                    self.launchAlert(str: "Impossible to fetch all the data")
////                    if (self.isAlert == false) {
////                        self.launchAlert(str: "Impossible to fetch all the data")
////                        self.isAlert = true
////                    }
//                    cell.imageView.backgroundColor = .black
//                } else {
//                    cell.displayContent(image: image!)
//                }
//            }
//        }
        
        cell.displayContent(strURL: Photos[indexPath.row].url)
        
        return cell
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
//    @IBOutlet weak var imageView: UIImageView!
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//        let imageUrlString = "https://www.nasa.gov/sites/default/files/styles/full_width_feature/public/thumbnails/image/stationmoon.jpg"
//        let imageUrl:URL = URL(string: imageUrlString)!
//
////        DispatchQueue.global(qos: .userInitiated) {
//
//            let imageData:NSData = NSData(contentsOf: imageUrl)!
//
////            DispatchQueue.main.async {
//                let image = UIImage(data: imageData as Data)
//                imageView.image = image
//                imageView.contentMode = UIViewContentMode.scaleAspectFit
//                self.view.addSubview(imageView)
////            }
////        }
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func launchAlert(str: String) {
        let alert = UIAlertController(title: "An error occured", message: str, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("Alert : \(str)")
        }))
        self.present(alert, animated: true, completion: nil)
    }

}
