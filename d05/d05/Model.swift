//
//  Model.swift
//  d05
//
//  Created by Clementine URQUIZAR on 3/22/19.
//  Copyright © 2019 Clementine URQUIZAR. All rights reserved.
//

import Foundation

struct Place {
    let title: String
    let subtitle: String
    let latitude: Double
    let longitude: Double
    let color: String
}

var Places: [Place] = [
    Place(title: "Ecole 42", subtitle: "Repère des geeks", latitude: 48.896607, longitude: 2.3185009999999693, color: "red"),
    Place(title: "Home", subtitle: "❤️", latitude: 48.9012508, longitude: 2.299965899999961, color: "red"),
    Place(title: "Lyon", subtitle: "Best city ever", latitude: 45.764043, longitude: 4.835658999999964, color: "blue"),
    Place(title: "Chez toto", subtitle: "QG des brunchs", latitude: 48.8530409, longitude: 2.36384350000003, color: "green"),
]
