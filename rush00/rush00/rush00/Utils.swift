//
//  Utils.swift
//  rush00
//
//  Created by Clementine URQUIZAR on 3/30/19.
//  Copyright © 2019 Clementine URQUIZAR. All rights reserved.
//

import Foundation

func formatDate(dateStr: String) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    if let creationDate = formatter.date(from: dateStr) {
        formatter.dateFormat = "dd MMM yyyy HH:mm"
        let finalDate = formatter.string(from: creationDate)
        return finalDate
    }
    return dateStr
}
