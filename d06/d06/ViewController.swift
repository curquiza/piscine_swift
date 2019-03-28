//
//  ViewController.swift
//  d06
//
//  Created by Clementine URQUIZAR on 3/28/19.
//  Copyright © 2019 Clementine URQUIZAR. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Init tap gesture
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGesture)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            print("Tapped")
            let touchedPoint = sender.location(in: self.view)
            addNewShape(posX: touchedPoint.x, posY: touchedPoint.y)
        }
    }
    
    func addNewShape(posX: CGFloat, posY: CGFloat) {
        print("Add new shape")
        let newShape = UIView(frame: CGRect(x: posX - 50, y: posY - 50, width: 100, height: 100))
        
        if (arc4random_uniform(2) == 1) {
          newShape.layer.cornerRadius = 50
        }
        newShape.backgroundColor = getShapeUIColor()
        
        self.view.addSubview(newShape)
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

