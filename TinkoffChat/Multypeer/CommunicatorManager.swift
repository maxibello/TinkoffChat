//
//  CommunicatorManager.swift
//  TinkoffChat
//
//  Created by MacBookPro on 01/04/2018.
//  Copyright © 2018 Maxim Kuznetsov. All rights reserved.
//

import Foundation

protocol CommunicatorDelegate: class {
    //discovering
    func didFoundUser(userID: String, userName: String?)
    func didLostUser(userID: String)
    
    //errors
    func failedToStartBrowsingForUsers(error: Error)
    func failedTostartAdvertising(error: Error)
    
    //messages
    func didReceiveMessage(text: String, fromUser: String, toUser: String)
}

class CommunicatorManager: CommunicatorDelegate {
    
    let communicator = MultipeerCommunicator()
    var delegate: UIViewController?
    
    init() {
        communicator.delegate = self
    }
    
    func didFoundUser(userID: String, userName: String?) {
        <#code#>
    }
    
    func didLostUser(userID: String) {
        <#code#>
    }
    
    func failedToStartBrowsingForUsers(error: Error) {
        <#code#>
    }
    
    func failedTostartAdvertising(error: Error) {
        <#code#>
    }
    
    func didReceiveMessage(text: String, fromUser: String, toUser: String) {
        <#code#>
    }
    
    
}
