//
//  TopicsViewController.swift
//  rush00
//
//  Created by Clementine URQUIZAR on 3/30/19.
//  Copyright © 2019 Clementine URQUIZAR. All rights reserved.
//

import Foundation
import UIKit

class TopicsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var token: String? = nil
    var userId: Int? = nil
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.rowHeight = UITableViewAutomaticDimension
            tableView.estimatedRowHeight = 100.0
        }
    }
    
    var topics: [Topic] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.hidesBackButton = true
        title = "Forum"
        self.getUserId()
        self.getTopics()
    }
    
    func reloadTopics() {
        self.topics = []
        self.getTopics()
    }
    
    func manageTopics(topics: [Topic]) {
        self.topics = topics
        tableView.reloadData()
    }
    
    func manageMessages(messages: [Message]) {
        print("Manage messages")
        print(messages)
    }
    
    func topicError(error: NSError) {
        print("Error topic")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "topicCell") as! TopicTableViewCell
        cell.topic = self.topics[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Pressing topic cell")
        let messagesViewController = self.storyboard?.instantiateViewController(withIdentifier: "messagesViewController") as! MessageViewController
        messagesViewController.topicId = topics[indexPath.row].id
        messagesViewController.token = self.token
        messagesViewController.userId = self.userId
        self.navigationController?.pushViewController(messagesViewController, animated: true)
    }
    
    func getUserId() {
        guard let t = self.token else { return }
        let component = URLComponents(string: "https://api.intra.42.fr/v2/me")
        let url = component?.url
        
        let request = NSMutableURLRequest(url: url! as URL)
        request.httpMethod = "GET"
        request.setValue("Bearer " + t, forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            (data, response, error) in
            if let err = error {
                print(err)
                print("Impossible to get user id")
            }
            else if let d = data {
                do {
                    let result = try JSONDecoder().decode(User.self, from: d)
                    self.userId = result.id
                }
                catch (let e) {
                    print(e)
                    print("Impossible to get user id")
                }
                
            }
        }
        task.resume()
    }
    
    func getTopics() {
        print("getTopics")
        
        guard let t = self.token else { return }
        let component = URLComponents(string: "https://api.intra.42.fr/v2/topics")
        let url = component?.url
        
        let request = NSMutableURLRequest(url: url! as URL)
        request.httpMethod = "GET"
        request.setValue("Bearer " + t, forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            (data, response, error) in
            if let err = error {
                print(err)
                DispatchQueue.main.async {
                    self.launchAlert(str: "Impossible to get topics")
                }
            }
            else if let d = data {
                do {
                    let result = try JSONDecoder().decode([Topic].self, from: d)
                    DispatchQueue.main.async {
                        self.manageTopics(topics: result)
                    }
                }
                catch (let e) {
                    print(e)
                    DispatchQueue.main.async {
                        self.launchAlert(str: "Impossible to get topics")
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
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let edit = UITableViewRowAction(style: .normal, title: "Edit") { action, index in
            print("Edit button tapped")
        }
        edit.backgroundColor = .lightGray
        
        let delete = UITableViewRowAction(style: .normal, title: "Delete") { action, index in
            print("Delete button tapped")
            self.deleteTopic(messageId: String(self.topics[indexPath.row].id))
        }
        delete.backgroundColor = .orange
        
        return [edit, delete]
    }
    
    func deleteTopic(messageId: String) {
        print("deleteMessages")
        guard let t = self.token else { return }
        let component = URLComponents(string: "https://api.intra.42.fr/v2/topics/\(messageId)")
        let url = component?.url
        
        let request = NSMutableURLRequest(url: url! as URL)
        request.httpMethod = "DELETE"
        request.setValue("Bearer " + t, forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            (data, response, error) in
            if let err = error {
                print(err)
                DispatchQueue.main.async {
                    self.launchAlert(str: "Impossible to delete topic")
                }
            }
            if let httpResponse = response as? HTTPURLResponse {
                print("http response \(httpResponse.statusCode)")
                if httpResponse.statusCode == 204 {
                    print("OK, topic deleted")
                    DispatchQueue.main.async {
                        self.reloadTopics()
                    }
                } else {
                    self.deleteTopicError()
                }
            } else {
                self.deleteTopicError()
            }
        }
        task.resume()
    }
    
    func deleteTopicError() {
        print("Impossible to delete topic")
        DispatchQueue.main.async {
            self.launchAlert(str: "Impossible to delete topic")
        }
    }
    
}
