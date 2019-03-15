//
//  APIController.swift
//  d04
//
//  Created by Clementine URQUIZAR on 3/13/19.
//  Copyright © 2019 Clementine URQUIZAR. All rights reserved.
//

import Foundation

protocol APITwitterDelegate: class {
    func manageTweet(tweet: [Tweet])
    func tweetError(error: NSError)
}

//class APIController: APITwitterDelegate {
class APIController {
    
    weak var delegate : APITwitterDelegate?
    let token: String
    
    init(apiTwitterDelegate: APITwitterDelegate?, token: String) {
        self.delegate = apiTwitterDelegate
        self.token = token
    }
    
//    func manageTweet(tweet: [Tweet]) {
//        print("manageTweet function")
//    }
//
//    func tweetError(error: NSError) {
//        print("tweetError function")
//    }
    
    func get100LastTweets(str: String) {
        print("100LastTweets function")
    }
}
