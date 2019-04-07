//
//  DeathNoteTableViewCell.swift
//  death-note
//
//  Created by Clementine URQUIZAR on 3/9/19.
//  Copyright © 2019 Clementine URQUIZAR. All rights reserved.
//

import UIKit

class DeathNoteTableViewCell: UITableViewCell {

//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var note: Note? {
        didSet {
            if let n = note {
                nameLabel?.text = n.name
                let formatter = DateFormatter()
                formatter.locale = Locale(identifier: "FR-fr")
                formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                dateLabel?.text = formatter.string(from: n.date)
                descriptionLabel?.text = n.description
            }
        }
    }
}
