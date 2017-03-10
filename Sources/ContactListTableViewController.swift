//
//  ContactListTableViewController.swift
//  Contacts
//
//  Created by Taylor Phillips on 3/10/17.
//  Copyright © 2017 Dev Mountain. All rights reserved.
//

import UIKit

class ContactListTableViewController: UITableViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ContactController.shared.contacts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath)
        let contact = ContactController.shared.contacts[indexPath.row]
        cell.textLabel?.text = contact.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
//            ContactController.shared.contacts[indexPath.row]
//            
//            ContactController.shared.delete(recordID: <#T##CKRecordID#>)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toContactDetail" {
            guard let indexPath = tableView.indexPathForSelectedRow, let contactDetailTVC = segue.destination as? ContactDetailsTableViewController else { return }
            let contact = ContactController.shared.contacts[indexPath.row]
            contactDetailTVC.contact = contact
            
        }
    }
}
