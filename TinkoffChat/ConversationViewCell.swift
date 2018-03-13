//
//  ConversationViewCell.swift
//  TinkoffChat
//
//  Created by MacBookPro on 09/03/2018.
//  Copyright © 2018 Maxim Kuznetsov. All rights reserved.
//

import UIKit



class ConversationViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var isOnlineImageView: UIImageView!
    @IBOutlet weak var lastMessageTimeLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        backgroundColor = UIColor.clear
    }
    
    func configureCell(conversationCell: Conversation) {
        
        tintColor = UIColor.black
        selectionStyle = .none
        
        nameLabel.text = conversationCell.name
        if let lastMessage = conversationCell.message {
            messageLabel.text = lastMessage
        } else {
            messageLabel.font = UIFont(name: "Helvetica", size: 15.0)
            messageLabel.text = "No messages yet"
        }
        
        if let lastMessageDate = conversationCell.date {
            lastMessageTimeLabel.text = dateToString(date: lastMessageDate)
        } else {
            lastMessageTimeLabel.text = ""
        }
        
        if conversationCell.hasUnreadMessages {
            messageLabel.font = UIFont.boldSystemFont(ofSize: 15.0)
        }
        
        if conversationCell.online {
            isOnlineImageView.image = UIImage(named: "online_icon")
            // бледно-желтый
            backgroundColor = UIColor(red:1.00, green:0.94, blue:0.60, alpha:1.0)
//            contentView.backgroundColor = UIColor(red:1.00, green:0.94, blue:0.60, alpha:1.0)
            
        } else {
            isOnlineImageView.image = UIImage(named: "offline_icon")
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func dateToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        if Calendar.current.isDateInToday(date) {
            dateFormatter.dateFormat = "HH:mm"
        } else {
            dateFormatter.dateFormat = "dd MMM"
        }
        
        return dateFormatter.string(from: date)
    }
    

}
