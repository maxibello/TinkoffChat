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
    func updateConversations(userID: String)
}

class NewConversationViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let messages = TestData.messages
    let incomingMessageCellID = "IncomingMessageCell"
    let outcomingMessageCellID = "OutcomingMessageCell"
    var conversation: Conversation?
    var messageCacheDelegate: IMessageCache?
    
    var communicator: MultipeerCommunicator?
    var conversationMessageCache: [Message]?
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var messageTextField: UITextField!
    @IBOutlet var sendMessageButton: UIButton!
    
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
                    let ouctomingMessage = Message(isIncoming: false, text: text)
                    messageCacheDelegate?.updateCache(userID: userID, message: ouctomingMessage)
                    conversationMessageCache?.append(ouctomingMessage)
                    updateUI()
                }
                
                messageTextField.text = ""
            }
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
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
        
        communicator?.conversationDelegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: .UIKeyboardWillHide, object: nil)
        
        if let userID = conversation?.userID {
            messageCacheDelegate?.updateConversations(userID: userID)
        }
        
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
        return conversationMessageCache?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let message = conversationMessageCache?[indexPath.row] else {
            fatalError("Filed to get message from cache")
        }
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
    
    func updateUI() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    @objc private func handleKeyboardNotification(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let keyboardFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            
            let isShowing = notification.name == .UIKeyboardWillShow
            
            self.view.frame.origin.y = isShowing ? -keyboardFrame.height : 0
            
            UIView.animate(withDuration: 0, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
    }

}

extension NewConversationViewController: CommunicatorDelegate {
    func didFoundUser(userID: String, userName: String?) {
        DispatchQueue.main.async {
            self.sendMessageButton.isEnabled = true
        }
    }
    
    func didLostUser(userID: String) {
        DispatchQueue.main.async {
            self.sendMessageButton.isEnabled = false
        }
    }
    
    func failedToStartBrowsingForUsers(error: Error) {
        
    }
    
    func failedTostartAdvertising(error: Error) {
        
    }
    
    func didReceiveMessage(text: String, fromUser: String, toUser: String) {
        if let userID = conversation?.userID {
            let receivedMessage = Message(isIncoming: true, text: text)
            messageCacheDelegate?.updateCache(userID: userID, message: receivedMessage)
            if fromUser == conversation?.userID {
                conversationMessageCache?.append(receivedMessage)
                updateUI()
            }
        }
    }
    
    
}
