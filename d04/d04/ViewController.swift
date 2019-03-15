//
//  ViewController.swift
//  d04
//
//  Created by Clementine URQUIZAR on 3/13/19.
//  Copyright © 2019 Clementine URQUIZAR. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, APITwitterDelegate {

    @IBOutlet weak var tweetTableView: UITableView! {
        didSet {
            tweetTableView.delegate = self
            tweetTableView.dataSource = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

//    @IBAction func last100TweetsRequest(_ sender: UIButton) {
//        print("ViewController - last100TweetsRequest")
//    }
//
    func manageTweet(tweet: [Tweet]) {
        print("manageTweet function")
    }
    
    func tweetError(error: NSError) {
        print("tweetError function")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TweetData.tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell") as! TweetTableViewCell
        cell.tweet = TweetData.tweets[indexPath.row]
        return cell
    }
    
    @IBAction func titiButton(_ sender: UIButton) {
        getToken()
    }
    func getToken() {
        if let api_key = ProcessInfo.processInfo.environment["TWITTER_API_KEY"] {
            if let api_secret_key = ProcessInfo.processInfo.environment["TWITTER_API_SECRET_KEY"] {
                let bearer = ((api_key + ":" + api_secret_key).data(using: String.Encoding.utf8))!.base64EncodedString(options: NSData.Base64EncodingOptions (rawValue: 0))
                
                let url = NSURL(string: "https://api.twitter.com/oauth2/token")
                let request = NSMutableURLRequest(url: url! as URL)
                request.httpMethod = "POST"
                request.setValue("Basic " + bearer, forHTTPHeaderField: "Authorization")
                request.setValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
                request.httpBody = "grant_type=client_credentials".data(using: String.Encoding.utf8)
                let task = URLSession.shared.dataTask(with: request as URLRequest) {
                    (data, response, error) in
//                    print(response!)
                    if let err = error {
                        print(err)
                    }
                    else if let d = data {
                        do {
                            if let dic: NSDictionary = try JSONSerialization.jsonObject(with: d, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                            print(dic)
                            }
                        }
                        catch (let err){
                            print(err)
                        }
                    }
                }
                task.resume()
            }
        }
    }
}

