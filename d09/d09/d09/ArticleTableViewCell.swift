//
//  ArticleTableViewCell.swift
//  d09
//
//  Created by Clementine URQUIZAR on 4/5/19.
//  Copyright © 2019 Clementine URQUIZAR. All rights reserved.
//

import UIKit
import curquiza2019

class ArticleTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var creationDateLabel: UILabel!
    @IBOutlet weak var modifDateLabel: UILabel!
//    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var contentLabel: UILabel!
    
    var article: Article? {
        didSet {
            if let a = article {
                titleLabel.text = a.title
                let formatter = DateFormatter()
                formatter.dateFormat = "dd/MM/yyyy HH:mm"
                creationDateLabel?.text = formatter.string(from: a.creation_date! as Date)
                modifDateLabel?.text = formatter.string(from: a.modif_date! as Date)
                contentLabel.text = a.content
            }
        }
    }
    
}
