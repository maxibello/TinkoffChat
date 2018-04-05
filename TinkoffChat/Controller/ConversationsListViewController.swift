//
//  ConversationsListViewController.swift
//  TinkoffChat
//
//  Created by MacBookPro on 09/03/2018.
//  Copyright © 2018 Maxim Kuznetsov. All rights reserved.
//

import UIKit

class ConversationsListViewController: UITableViewController, ThemesViewControllerDelegate {
    
    var conversations: [Conversation] = []
    let communicator = MultipeerCommunicator()
    var messageCache: [String: [Message]]?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        
        communicator.delegate = self
        
        title = "Tinkoff Chat"
        messageCache = [:]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - ThemesViewControllerDelegate
    
    func themesViewController(_ controller: ThemesViewController!, didSelectTheme selectedTheme: UIColor!) {
        logThemeChanging(selectedTheme: selectedTheme)
    }
    
    private func logThemeChanging(selectedTheme: UIColor) {
        let color: String
        switch selectedTheme {
        case .red:
            color = "Red Color"
        case .yellow:
            color = "Yellow Color"
        case .blue:
            color = "Blue Color"
        default:
            color = "Another Color"
        }
        print(color)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return conversations.filter({$0.online == true}).count
        }
        return conversations.filter({$0.online == false}).count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Online"
        }
        return "History"
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64.0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ConversationCell", for: indexPath) as? ConversationViewCell else {
            fatalError("Wrong cell type dequeued")
        }
        
        let conversation = conversations[indexPath.row]
        if let messages = messageCache?[conversation.userID],
            messages.count > 0 {
            let lastMessage = messages.last!
            conversation.date = lastMessage.date
            conversation.message = lastMessage.text
        }
        cell.configureCell(conversationCell: conversation)

        return cell
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowConversation" {
            if let conversationVC = segue.destination as? NewConversationViewController,
                let indexPath = tableView.indexPathForSelectedRow {

                let conversation = conversations[indexPath.row]
                conversation.hasUnreadMessages = false
                conversationVC.conversation = conversation
                conversationVC.conversationMessageCache = messageCache?[conversation.userID] ?? []
                conversationVC.communicator = communicator
                conversationVC.messageCacheDelegate = self
            }
        } else if segue.identifier == "ShowThemes" {
            if let navVC = segue.destination as? UINavigationController {
                if let themesVC = navVC.topViewController as? ThemesViewController {
                    themesVC.delegate = self
                }
            }
        }
    }
    
    func updateConversation(userID: String, message: Message) {
        if let conversation = conversations.first(where: {$0.userID == userID}) {
            conversation.date = message.date
            conversation.hasUnreadMessages = true
            conversation.message = message.text
        }
        updateTableView()
    }
    
    func updateTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func sortedConversations() -> [Conversation] {
        return conversations.sorted(by: { conversation1, conversation2 in
            if let date1 = conversation1.date, let date2 = conversation2.date {
                return date1 > date2
            } else {
                return conversation1.name!.compare(conversation2.name!) == .orderedAscending
            }
        })
    }
}

extension ConversationsListViewController: CommunicatorDelegate {
    func didFoundUser(userID: String, userName: String?) {
        if !conversations.contains(where: {$0.userID == userID}) {
            let conversation = Conversation(userID: userID, online: true, hasUnreadMessages: false, name: userName, message: nil, date: nil)
            conversations.append(conversation)
            print(conversation.userID)
            updateTableView()
        }

    }
    
    func didLostUser(userID: String) {
        if let foundedUserId = conversations.index(where: {$0.userID == userID}) {
            conversations.remove(at: foundedUserId)
        }
        updateTableView()
    }
    
    func failedToStartBrowsingForUsers(error: Error) {
        print("Failed to start browsing")
    }
    
    func failedTostartAdvertising(error: Error) {
        print("Failed to start advertising")
    }
    
    func didReceiveMessage(text: String, fromUser: String, toUser: String) {
        print("Did receive message")
        if messageCache?[fromUser] == nil {
            messageCache?[fromUser] = []
        }
        let incomingMessage = Message(isIncoming: true, text: text)
        messageCache?[fromUser]?.append(incomingMessage)
        updateConversation(userID: fromUser, message: incomingMessage)
    }
    
}

extension ConversationsListViewController: IMessageCache {
    
    func updateCache(userID: String, message: Message) {
        if messageCache?[userID] == nil {
            messageCache?[userID] = []
        }
        messageCache?[userID]?.append(message)
        updateTableView()
    }
    
}
