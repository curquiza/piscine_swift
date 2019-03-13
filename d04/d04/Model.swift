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
    
    var description: String {
        return "(name: \(name), text: \(text))"
    }
}
