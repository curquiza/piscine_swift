//
//  APIController.swift
//  d04
//
//  Created by Clementine URQUIZAR on 3/13/19.
//  Copyright © 2019 Clementine URQUIZAR. All rights reserved.
//

import Foundation

class APIController {
    
    weak var delegate : APITwitterDelegate?
    let token: String
    
    init(apiTwitterDelegate: APITwitterDelegate?, token: String) {
        self.delegate = apiTwitterDelegate
        self.token = token
    }
    
    func get100LastTweets(str: String) {
        let count: Int = 100
        print("100LastTweets function, str =", str, " count =", count)
        let escapedString = str.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        print("-> escaped str =", escapedString)
        
        let url = NSURL(string: "https://api.twitter.com/1.1/search/tweets.json?q=\(escapedString)&count=\(count)")
        let request = NSMutableURLRequest(url: url! as URL)
        request.httpMethod = "GET"
        request.setValue("Bearer " + self.token, forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            (data, response, error) in
            if let err = error {
                self.delegate?.tweetError(error: err as NSError)
            }
            else if let d = data {
                do {
                    var tweets: [Tweet] = []
                    if let dic: NSDictionary = try JSONSerialization.jsonObject(with: d, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                        if let tweetArray = dic["statuses"] as? [[String: AnyObject]] {
                            print("-> All tweets :")
                            for tweet in tweetArray {
                                let tweetText: String = tweet["text"] as! String
                                let tweetUserName: String = tweet["user"]?["name"] as! String
                                let date_str = tweet["created_at"] as! String
                                let formatter = DateFormatter()
                                formatter.dateFormat = "E MMM dd HH:mm:ss Z yyyy"
                                if let tweetCreationDate = formatter.date(from: date_str) {
                                    let newTweetInArray = Tweet(name: tweetUserName, text: tweetText, date: tweetCreationDate)
                                    print(newTweetInArray)
                                    print("-------")
                                    tweets.append(newTweetInArray)
                                }
                            }
                        }
                    }
                    self.delegate?.manageTweet(tweets: tweets)
                }
                catch (let e) {
                    print("Catch error: \(e)")
                }
                
            }
        }
        task.resume()
        
    }
}
