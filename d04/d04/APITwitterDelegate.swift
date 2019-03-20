//
//  APITwitterDelegate.swift
//  d04
//
//  Created by Clementine URQUIZAR on 3/17/19.
//  Copyright © 2019 Clementine URQUIZAR. All rights reserved.
//

import Foundation

protocol APITwitterDelegate: class {

    func manageTweet(tweets: [Tweet])
    func tweetError(error: NSError)

}
