//
//  Model.swift
//  d04
//
//  Created by Clementine URQUIZAR on 3/13/19.
//  Copyright © 2019 Clementine URQUIZAR. All rights reserved.
//

import Foundation

struct Tweet : CustomStringConvertible {
    let name: String
    let text: String
    let date: Date
    
    var description: String {
        return "(name: \(name), text: \(text), date: \(date)"
    }
}
//
//struct TweetData {
//    static var tweets: [Tweet] = [
//        Tweet(name: "Tweet 1", text: "Texte de tweet 1"),
//        Tweet(name: "Tweet 2", text: "Texte de tweet 2"),
//    ]
//}

