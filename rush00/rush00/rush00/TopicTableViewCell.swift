//
//  TopicTableViewCell.swift
//  rush00
//
//  Created by Clementine URQUIZAR on 3/30/19.
//  Copyright © 2019 Clementine URQUIZAR. All rights reserved.
//

import UIKit

class TopicTableViewCell: UITableViewCell {

    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    var topic: Topic? {
        didSet {
            if let t = topic {
                authorLabel?.text = t.author.login
                titleLabel?.text = t.name
                dateLabel?.text = formatDate(dateStr: t.created_at)
            }
        }
    }

}
