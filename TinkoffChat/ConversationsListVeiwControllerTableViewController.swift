//
//  ConversationsListVeiwControllerTableViewController.swift
//  TinkoffChat
//
//  Created by MacBookPro on 09/03/2018.
//  Copyright © 2018 Maxim Kuznetsov. All rights reserved.
//

import UIKit

class ConversationsListVeiwControllerTableViewController: UITableViewController {
    
    let conversations = TestData.conversations

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Tinkoff Chat"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        let filteredConversations: [Conversation]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ConversationCell", for: indexPath) as? ConversationViewCell else {
            fatalError("Wrong cell type dequeued")
        }
        print(indexPath.row)
        if indexPath.section == 0 {
            filteredConversations = conversations.filter { $0.online == true }
        } else {
            filteredConversations = conversations.filter { $0.online == false }
        }
        cell.configureCell(conversationCell: filteredConversations[indexPath.row])

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

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "ShowConversation" {
            if let conversationVC = segue.destination as? ConversationViewController,
                let indexPath = tableView.indexPathForSelectedRow {
                if indexPath.section == 0 {
                    conversationVC.conversation = conversations.filter({ $0.online == true })[indexPath.row]
                } else {
                    conversationVC.conversation = conversations.filter({ $0.online == false })[indexPath.row]
                }
            }
        }
    }
    

}
