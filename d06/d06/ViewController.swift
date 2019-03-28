//
//  ViewController.swift
//  d06
//
//  Created by Clementine URQUIZAR on 3/28/19.
//  Copyright © 2019 Clementine URQUIZAR. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    
    var dynamicAnimator: UIDynamicAnimator!
    var gravityBehavior: UIGravityBehavior!
    var collisionBehavior: UICollisionBehavior!
    var itemBehavior: UIDynamicItemBehavior!
    var motionManager: CMMotionManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Init tap gesture
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGesture)
        
        dynamicAnimator = UIDynamicAnimator(referenceView: self.view)
        
        // Gravity behaviour
        gravityBehavior = UIGravityBehavior()
        dynamicAnimator.addBehavior(gravityBehavior)
        
        // Collision behaviour
        collisionBehavior = UICollisionBehavior()
        collisionBehavior.setTranslatesReferenceBoundsIntoBoundary(with: self.view.alignmentRectInsets)
        dynamicAnimator.addBehavior(collisionBehavior)
        
        // Item Behavior
        itemBehavior = UIDynamicItemBehavior()
        itemBehavior.elasticity = 0.6
        dynamicAnimator.addBehavior(itemBehavior)
        
        // CoreMotion
        motionManager = CMMotionManager()
        if motionManager.isAccelerometerAvailable {
            motionManager.accelerometerUpdateInterval = 0.2
            let queue = OperationQueue.main
            motionManager.startAccelerometerUpdates(to: queue, withHandler: handleAccelerometer as! CMAccelerometerHandler)
        }
    }
    
    func handleAccelerometer(data: CMAccelerometerData?, error: NSError?) {
        print("Accelerometer")
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            print("Tapped")
            let touchedPoint = sender.location(in: self.view)
            addNewShape(x: touchedPoint.x, y: touchedPoint.y)
        }
    }
    
    
    var initialCenter = CGPoint()
    @objc func handlePan(gesture: UIPanGestureRecognizer) {
        guard gesture.view != nil else {return}
        let piece = gesture.view!

        if gesture.state == .began {
            gravityBehavior.removeItem(piece)
            initialCenter = piece.center
        } else if gesture.state == .ended {
            gravityBehavior.addItem(piece)
        } else if gesture.state == .changed {
            piece.center = gesture.location(in: piece.superview)
            dynamicAnimator.updateItem(usingCurrentState: piece)
        } else {
            piece.center = initialCenter
        }
        
    }
    
    @objc func handlePinch(gesture: UIPinchGestureRecognizer) {
        guard let piece = gesture.view else {return}
        
        if gesture.state == .began {
            gravityBehavior.removeItem(piece)
            itemBehavior.removeItem(piece)
        } else if gesture.state == .ended {
            gravityBehavior.addItem(piece)
            itemBehavior.addItem(piece)
        } else if gesture.state == .changed {
            collisionBehavior.removeItem(piece)
            let scale = gesture.scale
            piece.layer.bounds.size.height *= scale
            piece.layer.bounds.size.width *= scale
            piece.layer.cornerRadius *= scale
            gesture.scale = 1.0
            collisionBehavior.addItem(piece)
        }
    }

    @objc func handleRotation(gesture: UIRotationGestureRecognizer) {
        guard let piece = gesture.view else {return}
        
        if gesture.state == .began {
            gravityBehavior.removeItem(piece)
            itemBehavior.removeItem(piece)
        } else if gesture.state == .ended {
            gravityBehavior.addItem(piece)
            itemBehavior.addItem(piece)
        } else if gesture.state == .changed {
            collisionBehavior.removeItem(piece)
            piece.transform = piece.transform.rotated(by: gesture.rotation)
            gesture.rotation = 0
            collisionBehavior.addItem(piece)
        }
    }
    
    func addNewShape(x: CGFloat, y: CGFloat) {
        print("Add new shape")
        let newShape = UIView(frame: CGRect(x: x - 50, y: y - 50, width: 100, height: 100))
        if (arc4random_uniform(2) == 1) {
          newShape.layer.cornerRadius = 50
        }
        newShape.backgroundColor = getShapeUIColor()
        self.view.addSubview(newShape)
        
        itemBehavior.addItem(newShape)
        gravityBehavior.addItem(newShape)
        collisionBehavior.addItem(newShape)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        newShape.addGestureRecognizer(panGesture)
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch))
        newShape.addGestureRecognizer(pinchGesture)
        let rotationGesture = UIRotationGestureRecognizer(target: self, action: #selector(handleRotation))
        newShape.addGestureRecognizer(rotationGesture)
    }
    
    func getShapeUIColor() -> UIColor {
        let rand = arc4random_uniform(5)
        switch rand {
        case 0:
            return .red
        case 1:
            return .green
        case 2:
            return .yellow
        case 3:
            return .blue
        case 4:
            return .cyan
        default:
            return .black
        }
    }

}
