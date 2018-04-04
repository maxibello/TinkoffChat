//
//  ConversationCell.swift
//  TinkoffChat
//
//  Created by MacBookPro on 09/03/2018.
//  Copyright © 2018 Maxim Kuznetsov. All rights reserved.
//

import Foundation

protocol ConversationCellConfiguration: class {
    var name: String? {get set}
    var message: String? {get set}
    var date: Date? {get set}
    var online: Bool {get set}
    var hasUnreadMessages: Bool {get set}
}

class Conversation: ConversationCellConfiguration {
    var userID: String
    var name: String?
    var message: String?
    var date: Date?
    var online: Bool = false
    var hasUnreadMessages: Bool = false
    
    init(userID: String, online: Bool, hasUnreadMessages: Bool, name: String? = nil, message: String? = nil, date: Date? = nil) {
        self.userID = userID
        self.online = online
        self.hasUnreadMessages = hasUnreadMessages
        self.name = name
        self.message = message
        self.date = date
    }
}
