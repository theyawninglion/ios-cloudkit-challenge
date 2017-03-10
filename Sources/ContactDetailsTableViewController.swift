//
//  ContactDetailsTableViewController.swift
//  Contacts
//
//  Created by Taylor Phillips on 3/10/17.
//  Copyright © 2017 Dev Mountain. All rights reserved.
//

import UIKit

class ContactDetailsTableViewController: UITableViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let name = nameTextField.text,
            let email = emailTextField.text,
            let phoneNumber = phoneTextField.text,
            let phoneNumberAsInt = Int(phoneNumber)
            else { return }
        ContactController.shared.saveToCloudKit(name: name, email: email, phoneNumber: phoneNumberAsInt) {
            
        }
    }
    var contact: Contact?
   
}
