//
//  ConversationViewController.swift
//  TinkoffChat
//
//  Created by MacBookPro on 10/03/2018.
//  Copyright © 2018 Maxim Kuznetsov. All rights reserved.
//

import UIKit

class ConversationViewController: UITableViewController {

    let messages = TestData.messages
    let incomingMessageCellID = "IncomingMessageCell"
    let outcomingMessageCellID = "OutcomingMessageCell"
    var conversation: Conversation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self

        let incomingMessageNib = UINib(nibName: "IncomingMessageViewCell", bundle: nil)
        let outcomingMessageNib = UINib(nibName: "OutcomingMessageViewCell", bundle: nil)
        
        tableView.register(incomingMessageNib, forCellReuseIdentifier: incomingMessageCellID)
        tableView.register(outcomingMessageNib, forCellReuseIdentifier: outcomingMessageCellID)
        
        title = conversation?.name
        
        tableView.estimatedRowHeight = 150.0
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return messages.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
