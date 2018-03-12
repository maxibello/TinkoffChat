//
//  MessageCell.swift
//  TinkoffChat
//
//  Created by MacBookPro on 10/03/2018.
//  Copyright © 2018 Maxim Kuznetsov. All rights reserved.
//

import Foundation

protocol MessageCellConfiguration {
    var text: String? { get set }
    var isIncoming: Bool { get set }
}

class Message: MessageCellConfiguration {
    var text: String?
    var isIncoming: Bool
    
    init(isIncoming: Bool, text: String? = nil) {
        self.text = text
        self.isIncoming = isIncoming
    }
    
}
