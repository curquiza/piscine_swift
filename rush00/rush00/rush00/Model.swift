//
//  Model.swift
//  rush00
//
//  Created by Clementine URQUIZAR on 3/30/19.
//  Copyright © 2019 Clementine URQUIZAR. All rights reserved.
//

import Foundation

struct Author: Codable {
    let login: String
}

struct Topic : CustomStringConvertible, Codable {
    
    let name: String
    let created_at: String
    let author: Author
    let id: Int

    var description: String {
        return "(Topic -> title: \(name), date: \(created_at), author: \(author.login)"
    }
}

struct Message : CustomStringConvertible, Codable {
    let id: Int
    let author: Author
    let content: String
    let created_at: String
    let messageable_id: Int
    let replies: [Reply]
    
    var description: String {
        return "(Message -> author: \(author), content: \(content), date: \(created_at))"
    }
}

struct Reply : Codable {
    let id: Int
    let author: Author
    let content: String
    let created_at: String
}

struct Answer: CustomStringConvertible {
    let id: Int
    let author: String
    let content: String
    let created_at: String
    let messageable_id: Int
    let reply: Bool
    
    var description: String {
        return "(Message -> author: \(author), content: \(content), date: \(created_at), reply ? \(reply)"
    }
}

struct User: Codable {
    let id: Int
}
