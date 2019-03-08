//
//  Model.swift
//  death-note
//
//  Created by Clementine URQUIZAR on 3/8/19.
//  Copyright © 2019 Clementine URQUIZAR. All rights reserved.
//

import Foundation

struct Note {
    var name: String
    var date: Date
    var description: String
}

struct Data {
    static let deathNotes: [Note] = [
        Note(name: "Coco", date: Date(), description: "en codant du PHP"),
        Note(name: "Titi", date: Date(), description: "en codant du JS"),
        Note(name: "Tutu", date: Date(), description: "en codant du Swift"),
    ]
}
