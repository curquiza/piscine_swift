//
//  TweetTableViewCell.swift
//  d04
//
//  Created by Clementine URQUIZAR on 3/15/19.
//  Copyright © 2019 Clementine URQUIZAR. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var tweet: Tweet? {
        didSet {
            if let t = tweet {
                nameLabel?.text = t.name
                tweetTextLabel?.text = t.text
            }
        }
    }
}
