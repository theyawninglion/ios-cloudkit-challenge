//
//  ContactController.swift
//  Contacts
//
//  Created by Taylor Phillips on 3/10/17.
//  Copyright © 2017 Dev Mountain. All rights reserved.
//

import Foundation
import CloudKit

class ContactController {
    
    static let shared = ContactController()
    
    var contacts: [Contact] = []
    let cloudKitManager = CloudKitMangager()
    
    //MARK: - cruds
    
    func saveToCloudKit(name: String, email: String, phoneNumber: Int, completion: @escaping () -> Void){
        
        let contact = Contact(name: name, email: email, phoneNumber: phoneNumber)
        let record = CKRecord(contact: contact)
        self.contacts.append(contact)
        cloudKitManager.saveRecord(record: record) { 
            completion()
        }
        
    }
    func fetchRecordsFromCloudKit(completion: @escaping () -> Void){
        
        cloudKitManager.fetchRecords(type: Contact.typeKey) { (records) in
            let contacts = records.flatMap({ Contact(record: $0) })
            self.contacts = contacts
            completion()
        }
    }
    func delete(recordID: CKRecordID){
        cloudKitManager.deleteRecord(recordID: recordID) { (_, error) in
            if let error = error {
                print("Didn't Delete record from CloudKit\(error.localizedDescription)")
                return
            }
            print("Deleted record from CloudKit")
        }
        
    }
}
