//
//  ViewController.swift
//  d03
//
//  Created by Clementine URQUIZAR on 3/21/19.
//  Copyright © 2019 Clementine URQUIZAR. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    
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
        let image = urlToUIImage(stringURL: Photos[indexPath.row].url)
        cell.displayContent(image: image!)
        return cell
    }
    
    func urlToUIImage(stringURL: String) -> UIImage? {
        let imageURL = URL(string: stringURL)!
        let imageData: NSData = NSData(contentsOf: imageURL)!
        return UIImage(data: imageData as Data)
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


}

