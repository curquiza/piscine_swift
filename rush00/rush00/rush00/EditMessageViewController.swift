//
//  EditMessageViewController.swift
//  rush00
//
//  Created by Clementine URQUIZAR on 3/31/19.
//  Copyright © 2019 Clementine URQUIZAR. All rights reserved.
//

import Foundation

import Foundation

import UIKit

class EditMessageViewController : UIViewController {
    
    var messageId: Int? = nil
    var messageableId: Int? = nil
    var token: String? = nil
    var userId: Int? = nil
    var contentMessage: String? = nil

    @IBOutlet weak var messageTextField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Edit message view")
        title = "Edit message"
        
        messageTextField.layer.borderColor = #colorLiteral(red: 0.8265260687, green: 0.416873387, blue: 0.6644208343, alpha: 1)
        messageTextField.layer.borderWidth = 2
        messageTextField.layer.cornerRadius = 5.0
        
        guard let content = self.contentMessage else { return }
        messageTextField.text = content
    }
    
    func editMessage() {
        print("editMessages")
        guard let t = self.token else { return }
        guard let messsage_id = self.messageId else { return }
        guard let userId = self.userId else { return }
        guard let messageable_id = self.messageableId else { return }
        
        let component = URLComponents(string: "https://api.intra.42.fr/v2/messages/\(messsage_id)")
        let url = component?.url
        
        let request = NSMutableURLRequest(url: url! as URL)
        request.httpMethod = "PUT"
        request.setValue("Bearer " + t, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        

            
        let json: [String: Any] = ["message": ["author_id": String(userId), "content": messageTextField.text!, "messageable_id": String(messageable_id), "messageable_type": "Topic"]]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            (data, response, error) in
            if let err = error {
                print(err)
                DispatchQueue.main.async {
                    self.launchAlert(str: "Impossible to edit message")
                }
            }
            if let httpResponse = response as? HTTPURLResponse {
                print("http response \(httpResponse.statusCode)")
                if httpResponse.statusCode == 204 {
                    print("OK, message deleted")
                    DispatchQueue.main.async {
                        self.navigationController?.popViewController(animated: true)
                    }
                    
                } else {
                    self.editMessageError()
                }
            } else {
                self.editMessageError()
            }
        }
        task.resume()
    }
    
    func editMessageError() {
        print("Impossible to edit message")
        DispatchQueue.main.async {
            self.launchAlert(str: "Impossible to edit message")
        }
    }
    
    func launchAlert(str: String) {
        let alert = UIAlertController(title: "An error occured", message: str, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("Alert : \(str)")
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func editMessageAction(_ sender: UIBarButtonItem) {
        self.editMessage()
    }
    
}
