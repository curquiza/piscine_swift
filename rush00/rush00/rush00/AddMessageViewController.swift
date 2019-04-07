//
//  AddMessageViewController.swift
//  rush00
//
//  Created by Clementine URQUIZAR on 3/31/19.
//  Copyright © 2019 Clementine URQUIZAR. All rights reserved.
//

import Foundation

import UIKit

class AddMessageViewController : UIViewController {
    
    var messageableId: Int? = nil
    var token: String? = nil
    var userId: Int? = nil
    
    @IBOutlet weak var messageTextField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Add message view")
        title = "Add new message"

        messageTextField.layer.borderColor = #colorLiteral(red: 0.3669775426, green: 0.5502967238, blue: 1, alpha: 1)
        messageTextField.layer.borderWidth = 2
        messageTextField.layer.cornerRadius = 5.0
    }
    
    func addMessage() {
        print("addMessages")
        guard let t = self.token else { return }
        let component = URLComponents(string: "https://api.intra.42.fr/v2/messages")
        let url = component?.url

        let request = NSMutableURLRequest(url: url! as URL)
        request.httpMethod = "POST"
        request.setValue("Bearer " + t, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let id = self.messageableId else { return }
        guard let userId = self.userId else { return }
      
        let json: [String: Any] = ["message": ["author_id": String(userId), "content": messageTextField.text!, "messageable_id": String(id), "messageable_type": "Topic"]]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        request.httpBody = jsonData
        
        //Convert back to string. Usually only do this for debugging
//        if let JSONString = String(data: request.httpBody!, encoding: String.Encoding.utf8) {
//            print ("ON AFFICHE LE JSON !!")
//            print(JSONString)
//        } else {
//            print("C'est POURRI !!!")
//        }

        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            (data, response, error) in
            if let err = error {
                print(err)
                DispatchQueue.main.async {
                    self.launchAlert(str: "Impossible to post message")
                }
            }
            else if let d = data {
                
                do {
                    let result = try JSONDecoder().decode(Message.self, from: d)
                    print("Ok POST message")
                    print(result)
                    DispatchQueue.main.async {
                        self.navigationController?.popViewController(animated: true)
                    }
                }
                catch (let e) {
                    print(e)
                    DispatchQueue.main.async {
                        self.launchAlert(str: "Impossible to post message!")
                    }
                }

            }
        }
        task.resume()
    }
    
    func launchAlert(str: String) {
        let alert = UIAlertController(title: "An error occured", message: str, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("Alert : \(str)")
        }))
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func doneButton(_ sender: Any) {
        self.addMessage()
    }
    
}
