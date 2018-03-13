//
//  IncomingMessageViewCell.swift
//  TinkoffChat
//
//  Created by MacBookPro on 10/03/2018.
//  Copyright © 2018 Maxim Kuznetsov. All rights reserved.
//

import UIKit

class MessageViewCell: UITableViewCell {

    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var bubbleView: BubbleView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with cellData: Message) {
        selectionStyle = .none
        messageLabel.text = cellData.text ?? ""
        bubbleView.isIncoming = cellData.isIncoming
    }
    
}
