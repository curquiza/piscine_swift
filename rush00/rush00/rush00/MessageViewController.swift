//
//  MessageViewController.swift
//  rush00
//
//  Created by Clementine URQUIZAR on 3/30/19.
//  Copyright © 2019 Clementine URQUIZAR. All rights reserved.
//

import Foundation
import UIKit

class MessageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var messageTableView: UITableView! {
    
        didSet {
            messageTableView.rowHeight = UITableViewAutomaticDimension
            messageTableView.estimatedRowHeight = 100.0
        }
    }
    
    var topicId: Int? = nil
    var token: String? = nil
    var userId: Int? = nil

    var answers: [Answer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Messages view")
        title = "Answers"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("MessageView viewWillAppear")
        self.reloadAnswers()
    }
    
    func reloadAnswers(){
        self.answers = []
        guard let id = self.topicId else { return }
        self.getMessages(topic_id: String(id))
    }
    
    func getMessages(topic_id : String) {
        print("getMessages")
        guard let t = self.token else { return }
        let component = URLComponents(string: "https://api.intra.42.fr/v2/topics/\(topic_id)/messages")
        let url = component?.url
        
        let request = NSMutableURLRequest(url: url! as URL)
        request.httpMethod = "GET"
        request.setValue("Bearer " + t, forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            (data, response, error) in
            if let err = error {
                print(err)
                DispatchQueue.main.async {
                    self.launchAlert(str: "Impossible to get answers")
                }
            }
            else if let d = data {
                do {
                    let result = try JSONDecoder().decode([Message].self, from: d)
                    DispatchQueue.main.async {
                        self.manageMessages(messages: result)
                    }
                }
                catch (let e) {
                    print(e)
                    DispatchQueue.main.async {
                        self.launchAlert(str: "Impossible to get answers")
                    }
                }
                
            }
        }
        task.resume()
    }
    
    func manageMessages(messages: [Message]) {
        
        for message in messages {
            let id = message.id
            let author = message.author.login
            let content = message.content
            let created_at = message.created_at
            self.answers.append(Answer(id: id, author: author, content: content, created_at: created_at, messageable_id: message.messageable_id, reply: false))
            for reply in message.replies {
                let id = reply.id
                let author = reply.author.login
                let content = reply.content
                let created_at = reply.created_at
                self.answers.append(Answer(id: id, author: author, content: content, created_at: created_at, messageable_id: -1, reply: true))
            }
        }
        messageTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell") as! MessageTableViewCell
        cell.answer = self.answers[indexPath.row]
        return cell
    }
    
    func launchAlert(str: String) {
        let alert = UIAlertController(title: "An error occured", message: str, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("Alert : \(str)")
        }))
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func addMessageButton(_ sender: UIBarButtonItem) {
        print("AddMessageButton")
        let addMessageViewController = self.storyboard?.instantiateViewController(withIdentifier: "addMessageViewController") as! AddMessageViewController
        addMessageViewController.messageableId = answers.first?.messageable_id
        addMessageViewController.token = self.token
        addMessageViewController.userId = self.userId
        self.navigationController?.pushViewController(addMessageViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let edit = UITableViewRowAction(style: .normal, title: "Edit") { action, index in
            print("Edit button tapped")
            let editMessageViewController = self.storyboard?.instantiateViewController(withIdentifier: "editMessageViewController") as! EditMessageViewController
            editMessageViewController.contentMessage = self.answers[indexPath.row].content
            editMessageViewController.userId = self.userId
            editMessageViewController.token = self.token
            editMessageViewController.messageId = self.answers[indexPath.row].id
            editMessageViewController.messageableId = self.answers.first?.messageable_id
            self.navigationController?.pushViewController(editMessageViewController, animated: true)
        }
        edit.backgroundColor = .lightGray
        
        let delete = UITableViewRowAction(style: .normal, title: "Delete") { action, index in
            print("Delete button tapped")
            self.deleteMessage(messageId: String(self.answers[indexPath.row].id))
        }
        delete.backgroundColor = .orange
        
        return [edit, delete]
    }
    
    func deleteMessage(messageId: String) {
        print("deleteMessages")
        guard let t = self.token else { return }
        let component = URLComponents(string: "https://api.intra.42.fr/v2/messages/\(messageId)")
        let url = component?.url
        
        let request = NSMutableURLRequest(url: url! as URL)
        request.httpMethod = "DELETE"
        request.setValue("Bearer " + t, forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            (data, response, error) in
            if let err = error {
                print(err)
                DispatchQueue.main.async {
                    self.launchAlert(str: "Impossible to delete message")
                }
            }
            if let httpResponse = response as? HTTPURLResponse {
                print("http response \(httpResponse.statusCode)")
                if httpResponse.statusCode == 204 {
                    print("OK, message deleted")
                    DispatchQueue.main.async {
                        self.reloadAnswers()
                    }
                } else {
                    self.deleteMessageError()
                }
            } else {
                self.deleteMessageError()
            }
        }
        task.resume()
    }
    
    func deleteMessageError() {
        print("Impossible to delete message")
        DispatchQueue.main.async {
            self.launchAlert(str: "Impossible to delete message")
        }
    }

}
