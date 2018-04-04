//
//  ConversationsListViewController.swift
//  TinkoffChat
//
//  Created by MacBookPro on 09/03/2018.
//  Copyright © 2018 Maxim Kuznetsov. All rights reserved.
//

import UIKit

class ConversationsListViewController: UITableViewController, ThemesViewControllerDelegate {

//    let conversations = TestData.conversations
    var conversations: [Conversation] = []
    let communicator = MultipeerCommunicator()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        
        communicator.delegate = self
        
        title = "Tinkoff Chat"
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
//        let filteredConversations: [Conversation]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ConversationCell", for: indexPath) as? ConversationViewCell else {
            fatalError("Wrong cell type dequeued")
        }
        
//        if indexPath.section == 0 {
//            filteredConversations = conversations.filter { $0.online == true }
//        } else {
//            filteredConversations = conversations.filter { $0.online == false }
//        }
        cell.configureCell(conversationCell: conversations[indexPath.row])

        return cell
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowConversation" {
            if let conversationVC = segue.destination as? ConversationViewController,
                let indexPath = tableView.indexPathForSelectedRow {
//                if indexPath.section == 0 {
//                    conversationVC.conversation = conversations.filter({ $0.online == true })[indexPath.row]
//                } else {
//                    conversationVC.conversation = conversations.filter({ $0.online == false })[indexPath.row]
//                }
            }
        } else if segue.identifier == "ShowThemes" {
            if let navVC = segue.destination as? UINavigationController {
                if let themesVC = navVC.topViewController as? ThemesViewController {
                    themesVC.delegate = self
                }
            }
        }
    }
}

extension ConversationsListViewController: CommunicatorDelegate {
    func didFoundUser(userID: String, userName: String?) {
        print("FOUND USER")
        let conversation = Conversation(userID: userID, online: true, hasUnreadMessages: false, name: userName, message: nil, date: nil)
        conversations.append(conversation)
        tableView.reloadData()
    }
    
    func didLostUser(userID: String) {
        print("LOST USER")
        if let foundedUserId = conversations.index(where: {$0.userID == userID}) {
            conversations.remove(at: foundedUserId)
        }
        tableView.reloadData()
    }
    
    func failedToStartBrowsingForUsers(error: Error) {
        print("FAILED TO START BROWSING")
    }
    
    func failedTostartAdvertising(error: Error) {
        print("FAILED TO START ADVERTISING")
    }
    
    func didReceiveMessage(text: String, fromUser: String, toUser: String) {
        print("DID RECEIVE MESSAGE")
    }
    
}
