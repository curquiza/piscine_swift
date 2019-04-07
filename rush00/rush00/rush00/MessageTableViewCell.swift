//
//  MessageTableViewCell.swift
//  rush00
//
//  Created by Clementine URQUIZAR on 3/30/19.
//  Copyright © 2019 Clementine URQUIZAR. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {

    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    let replyColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
    let replySize: CGFloat = 15
    let messageColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    let messageSize: CGFloat = 18
    
    var answer: Answer? {
        didSet {
            if let a = answer {
                if a.reply == true {
                    authorLabel.textColor = replyColor
                    dateLabel.textColor = replyColor
                    contentLabel.textColor = replyColor
                    authorLabel.font = UIFont.italicSystemFont(ofSize: replySize)
                    dateLabel.font = UIFont.italicSystemFont(ofSize: replySize)
                    contentLabel.font = UIFont.italicSystemFont(ofSize: replySize)
                } else {
                    authorLabel.textColor = messageColor
                    dateLabel.textColor = messageColor
                    contentLabel.textColor = messageColor
                    authorLabel.font = UIFont.systemFont(ofSize: messageSize)
                    dateLabel.font = UIFont.systemFont(ofSize: messageSize)
                    contentLabel.font = UIFont.systemFont(ofSize: messageSize)
                }
                
                authorLabel?.text = a.author
                dateLabel?.text = formatDate(dateStr: a.created_at)
                contentLabel?.text = a.content
            }
        }
    }
}
