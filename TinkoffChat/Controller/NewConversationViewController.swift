//
//  NewConversationViewController.swift
//  TinkoffChat
//
//  Created by m.kuznetsov1 on 04.04.2018.
//  Copyright © 2018 Maxim Kuznetsov. All rights reserved.
//

import UIKit

protocol IMessageCache {
    func updateCache(userID: String, message: Message)
}

class NewConversationViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let messages = TestData.messages
    let incomingMessageCellID = "IncomingMessageCell"
    let outcomingMessageCellID = "OutcomingMessageCell"
    var conversation: Conversation?
    var messageCacheDelegate: IMessageCache?
    
    var communicator: MultipeerCommunicator?
    var messageCache: [String: [Message]]?
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var messageTextField: UITextField!
    
    @IBAction func sendMessageAction(_ sender: Any) {
        if let text = messageTextField.text {
            if text != "" {
                if let userID = conversation?.userID {
                    communicator?.sendMessage(string: text, to: userID) {
                        (success, error) in
                        
                        if let error = error {
                            print(error)
                        }
                    }
                    // сохраняем в cache
                    messageCacheDelegate?.updateCache(userID: userID, message: Message(isIncoming: false, text: text))
                    
                }
//                Message.saveMessage(with: conversationId, text: text, isIncoming: false)
                
                messageTextField.text = ""
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        
        let incomingMessageNib = UINib(nibName: "IncomingMessageViewCell", bundle: nil)
        let outcomingMessageNib = UINib(nibName: "OutcomingMessageViewCell", bundle: nil)
        
        tableView.register(incomingMessageNib, forCellReuseIdentifier: incomingMessageCellID)
        tableView.register(outcomingMessageNib, forCellReuseIdentifier: outcomingMessageCellID)
        
        title = conversation?.name
        
        tableView.estimatedRowHeight = 150.0
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorStyle = .none
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return messages.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        let cellIdentifier: String
        if message.isIncoming {
            cellIdentifier = incomingMessageCellID
        } else {
            cellIdentifier = outcomingMessageCellID
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MessageViewCell else {
            fatalError("Wrong cell type dequeued")
        }
        cell.configure(with: message)
        
        return cell
    }

}
