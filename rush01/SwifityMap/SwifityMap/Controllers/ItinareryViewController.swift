//
//  ItinareryViewController.swift
//  SwifityMap
//
//  Created by Clementine URQUIZAR on 4/6/19.
//  Copyright © 2019 Felicien RENAUD. All rights reserved.
//

import UIKit
import MapKit


class ItinareryViewController: UIViewController, UITextFieldDelegate  {
    
    var resultSearchController : UISearchController? = nil
    
    var traceDelegate: traceDelegate?
    var fromItem: MKPlacemark?
    var toItem: MKPlacemark?
    
    @IBOutlet weak var fromTextField: UITextField! {
        didSet {
            fromTextField.delegate = self
        }
    }
    @IBOutlet weak var toTextField: UITextField! {
        didSet {
            toTextField.delegate = self
        }
    }
    @IBAction func traceButton(_ sender: UIButton) {
        guard let f = fromItem?.coordinate else { return }
        guard let t = toItem?.coordinate else { return }
        traceDelegate?.traceRoute(sourceLocation: f, destinationLocation: t)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBOutlet weak var traceButtonUI: UIButton!

    override func viewDidLoad() {
        print("ItinareryViewController view")
        setTextField(textField: fromTextField, placeholder: "From...")
        setTextField(textField: toTextField, placeholder: "To...")
        
        let color = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        traceButtonUI.layer.cornerRadius = 5
        traceButtonUI.backgroundColor = .white
        traceButtonUI.layer.borderColor = color.cgColor
        traceButtonUI.layer.borderWidth = 1
        traceButtonUI.contentEdgeInsets = UIEdgeInsetsMake(10,10,10,10)
        traceButtonUI.tintColor = color
    }
    
    func setTextField(textField: UITextField, placeholder: String) {
        textField.placeholder = placeholder
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 50))
        textField.backgroundColor = #colorLiteral(red: 0.9081411234, green: 0.9081411234, blue: 0.9081411234, alpha: 1)
        textField.layer.cornerRadius = 15
        textField.leftViewMode = .always
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.endEditing(true)
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "itinarerySearchViewController") as! ItinarerySearchViewController
        if textField.placeholder == "From..." {
            viewController.destType = "from"
        } else {
            viewController.destType = "to"
        }
        viewController.saveItinareryDelegate = self
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
}

protocol saveItinareryValueDelegate {
    func saveValue(destType: String?, mapItem: MKPlacemark?)
}

extension ItinareryViewController: saveItinareryValueDelegate {
    func saveValue(destType: String?, mapItem: MKPlacemark?) {
        if destType == "from" {
            fromTextField.text = mapItem?.title
            fromItem = mapItem
        } else {
            toTextField.text = mapItem?.title
            toItem = mapItem
        }
    }
}
