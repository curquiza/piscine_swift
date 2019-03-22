//
//  PhotoViewController.swift
//  d03
//
//  Created by Clementine URQUIZAR on 3/22/19.
//  Copyright © 2019 Clementine URQUIZAR. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController, UIScrollViewDelegate {

    var image: UIImage?
    var imageView: UIImageView?
    
    @IBOutlet weak var photoScrollView: UIScrollView! {
        didSet {
            photoScrollView.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if image != nil {
            self.imageView = UIImageView(image: image)
            if self.imageView != nil {
                photoScrollView.addSubview(self.imageView!)
                photoScrollView.contentSize = (imageView?.frame.size)!
//                photoScrollView.maximumZoomScale = image!.size.width
//                photoScrollView.minimumZoomScale = 0.3
                setZoomScale()
            }
        }

    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func setZoomScale() {
        let imageViewSize = imageView!.bounds.size
        let scrollViewSize = photoScrollView.bounds.size
        let widthScale = scrollViewSize.width / imageViewSize.width
        let heightScale = scrollViewSize.height / imageViewSize.height
        
        photoScrollView.minimumZoomScale = min(widthScale, heightScale)
        photoScrollView.zoomScale = 1.0
    }

}
