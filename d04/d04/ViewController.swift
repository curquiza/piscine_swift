//
//  ViewController.swift
//  d04
//
//  Created by Clementine URQUIZAR on 3/13/19.
//  Copyright © 2019 Clementine URQUIZAR. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, APITwitterDelegate, UITextFieldDelegate {

    var apiController: APIController?
    var tweets: [Tweet] = []
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var tweetTableView: UITableView! {
        didSet {
            tweetTableView.delegate = self
            tweetTableView.dataSource = self
        }
    }
    
    // enlever la selection de cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Tweets"
        textField.delegate = self
        getToken()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("Press enter")
        let t = textField.text!
        if (t != "") {
            print("-> with text field : \(t)")
            if self.apiController != nil {
                self.apiController?.get100LastTweets(str: t)
            } else {
              launchAlert(str: "Impossible to fetch Twitter data.")
            }
        }
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func manageTweet(tweets: [Tweet]) {
        print("manageTweet function")
        self.tweets = tweets
        DispatchQueue.main.async {
            self.tweetTableView.reloadData()
        }
    }
    
    func tweetError(error: NSError) {
        print("tweetError function")
        print("-> Error : \(error)")
        launchAlert(str: error.localizedDescription)
    }
    
    func launchAlert(str: String) {
        let alert = UIAlertController(title: "An error occured", message: str, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("Alert : \(str)")
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return TweetData.tweets.count
        return self.tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell") as! TweetTableViewCell
//        cell.tweet = TweetData.tweets[indexPath.row]
        cell.tweet = self.tweets[indexPath.row]
        return cell
    }
    
    // GET TWITTER TOKEN
    
    func getToken() {
        print("getToken function")
        if let api_key = ProcessInfo.processInfo.environment["TWITTER_API_KEY"] {
            if let api_secret_key = ProcessInfo.processInfo.environment["TWITTER_API_SECRET_KEY"] {
                let bearer = ((api_key + ":" + api_secret_key).data(using: String.Encoding.utf8))!.base64EncodedString(options: NSData.Base64EncodingOptions (rawValue: 0))
                
                let url = NSURL(string: "https://api.twitter.com/oauth2/tokn")
                let request = NSMutableURLRequest(url: url! as URL)
                request.httpMethod = "POST"
                request.setValue("Basic " + bearer, forHTTPHeaderField: "Authorization")
                request.setValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
                request.httpBody = "grant_type=client_credentials".data(using: String.Encoding.utf8)
                
//                let sema = DispatchSemaphore( value: 0)
                
                let task = URLSession.shared.dataTask(with: request as URLRequest) {
                    (data, response, error) in
//                    print(response!)
                    if let err = error {
                        print(err)
                        self.launchAlert(str: "Impossible to get Twitter token.")
                    }
                    else if let d = data {
                        do {
                            if let dic: NSDictionary = try JSONSerialization.jsonObject(with: d, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
//                                print(dic)
                                if let accessToken = dic["access_token"] as? String {
                                    print("-> token got =", accessToken)
                                    self.apiController = APIController(apiTwitterDelegate: self, token: accessToken)
                                } else {
                                    print("No access_token")
                                    self.launchAlert(str: "Impossible to get Twitter token.")
                                }
                            }
                        }
                        catch (let err) {
                            print(err)
                            self.launchAlert(str: "Impossible to get Twitter token.")
                        }
                    }
//                    sema.signal()
                }
                
                task.resume()
//                sema.wait()

            }
        }
    }
}

