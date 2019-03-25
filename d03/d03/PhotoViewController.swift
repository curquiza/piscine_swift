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
                photoScrollView.contentSize = (imageView?.bounds.size)!
                setZoomScale(view.bounds.size)
                photoScrollView.addSubview(self.imageView!)
//                photoScrollView.maximumZoomScale = image!.size.width
//                photoScrollView.minimumZoomScale = 0.3
            }
        }

    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setZoomScale(view.bounds.size)
    }
    
    func setZoomScale(_ size: CGSize) {
        let widthScale = size.width / (imageView?.bounds.width)!
        let heightScale = size.height / (imageView?.bounds.height)!
        let minScale = min(widthScale, heightScale)
        
        photoScrollView.minimumZoomScale = minScale
        photoScrollView.zoomScale = minScale
    }
    
//    func setZoomScale() {
//        let imageViewSize = imageView!.bounds.size
//        let scrollViewSize = photoScrollView.bounds.size
//        let widthScale = scrollViewSize.width / imageViewSize.width
//        let heightScale = scrollViewSize.height / imageViewSize.height
//
//        photoScrollView.minimumZoomScale = min(widthScale, heightScale)
//        photoScrollView.zoomScale = 1.0
//    }
    
//    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
//
//        coordinator .animate(alongsideTransition: { context in
//            let newImageView = self.imageView
//            newImageView?.bounds = (self.imageView?.bounds)!
//            newImageView?.center = (self.imageView?.center)!
//        }, completion: nil)
//        setZoomScale()
//    }

}
