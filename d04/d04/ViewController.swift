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
}

