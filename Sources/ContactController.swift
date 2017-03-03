//
//  ContactController.swift
//  Contacts
//
//  Created by Taylor Phillips on 3/3/17.
//  Copyright © 2017 Dev Mountain. All rights reserved.
//

import Foundation
import CloudKit

class ContactController {
    
    static let shared = ContactController()
    private(set) var contacts = [Contact]()
    
    private let cloudKitManager = CloudKitManager()
    
    func createContact(name: String, phoneNumber: Int, email: String, completion: @escaping ((Error?) -> Void) = { _ in }) {
        let contact = Contact(name: name, phoneNumber: phoneNumber, email: email)
        cloudKitManager.saveRecord(contact.cloudKitRecord) { (nil, error) in
            if let error = error {
                NSLog("Error saviv\(contact.name) to cloudkit with error:\n\(error.localizedDescription)")
                return
            }
            self.contacts.insert(contact, at: 0)
        }
    }
    

    func refreshData(completion: @escaping ((Error?) -> Void) = { _ in}) {
        
        let sortDescriptor = [NSSortDescriptor(key: Contact.nameKey, ascending: false)]
        
        cloudKitManage
    }
    
}
