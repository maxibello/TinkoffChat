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

        let incomingMessageNib = UINib(nibName: "IncomingMessageViewCell", bundle: nil)
        let outcomingMessageNib = UINib(nibName: "OutcomingMessageViewCell", bundle: nil)
        
        tableView.register(incomingMessageNib, forCellReuseIdentifier: incomingMessageCellID)
        tableView.register(outcomingMessageNib, forCellReuseIdentifier: outcomingMessageCellID)
        
        title = conversation?.name
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
