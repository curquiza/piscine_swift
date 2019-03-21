//
//  CollectionViewCell.swift
//  d03
//
//  Created by Clementine URQUIZAR on 3/21/19.
//  Copyright © 2019 Clementine URQUIZAR. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    func displayContent(image: UIImage) {
        imageView.image = image
        imageView.contentMode = UIViewContentMode.scaleAspectFit
    }
}
