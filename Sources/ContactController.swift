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
    
    func fetchAllContactsFromCloudKit(completion: @ escaping ([Contact]) -> Void) {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Contact", predicate: predicate)
        privateDatabase.perform(query, inZoneWith: nil) { (records, error) in
            guard let records = records else { return }
            let contacts = records.flatMap({Contact(cloudKitRecord: $0) })
            completion(contacts)
        }
    }

    

    func refreshContacts(completion: @escaping ((Error?) -> Void) = { _ in}) {
        
        let sortDescriptor = [NSSortDescriptor(key: Contact.nameKey, ascending: false)]
        
        cloudKitManager.fetchRecordsWithType(<#T##type: String##String#>, predicate: <#T##NSPredicate#>, recordFetchedBlock: <#T##((CKRecord) -> Void)?##((CKRecord) -> Void)?##(CKRecord) -> Void#>, completion: <#T##(([CKRecord]?, Error?) -> Void)?##(([CKRecord]?, Error?) -> Void)?##([CKRecord]?, Error?) -> Void#>)
    }
    
}
