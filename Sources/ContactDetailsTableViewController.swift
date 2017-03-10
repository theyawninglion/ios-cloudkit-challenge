//
//  ContactDetailsTableViewController.swift
//  Contacts
//
//  Created by Taylor Phillips on 3/10/17.
//  Copyright © 2017 Dev Mountain. All rights reserved.
//

import UIKit

class ContactDetailsTableViewController: UITableViewController {

    //MARK: - outlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    //MARK: -  actions
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let name = nameTextField.text,
            let email = emailTextField.text,
            let phoneNumber = phoneTextField.text,
            let phoneNumberAsInt = Int(phoneNumber)
            else { return }
        
        ContactController.shared.saveToCloudKit(name: name, email: email, phoneNumber: phoneNumberAsInt) {
        }
        let _ = self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    var contact: Contact?{
        didSet{
            DispatchQueue.main.async {
                self.updateViews()
            }
        }
    }
   
    //MARK: -  functions
    func updateViews(){
        guard let contact = contact else { return }
         nameTextField.text = contact.name
        phoneTextField.text = "\(contact.phoneNumber)"
        emailTextField.text = contact.email
        
       
        
//        ContactController.shared.saveToCloudKit(name: contact.name, email: contact.email, phoneNumber: contact.phoneNumber, completion: <#T##() -> Void#>)
    }
}
