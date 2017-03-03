//
//  ContactDetailViewController.swift
//  Contacts
//
//  Created by Taylor Phillips on 3/3/17.
//  Copyright © 2017 Dev Mountain. All rights reserved.
//

import UIKit

class ContactDetailViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    
    var contact: Contact?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let name = nameTextField.text,
            let phoneNumber = phoneNumberTextField.text as? Int,
            let email = emailTextField.text
            else { return }
        
        ContactController.shared.createContact(name: name, phoneNumber: phoneNumber, email: email) { (_) in
            DispatchQueue.main.async {
                self.nameTextField.resignFirstResponder()
                self.phoneNumberTextField.resignFirstResponder()
                self.emailTextField.resignFirstResponder()
            }
        }
        let _ = self.navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
