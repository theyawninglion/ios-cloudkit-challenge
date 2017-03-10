//
//  Contact.swift
//  Contacts
//
//  Created by Taylor Phillips on 3/10/17.
//  Copyright © 2017 Dev Mountain. All rights reserved.
//

import Foundation
import CloudKit

class Contact {
    
    //MARK: - keys
    static let typeKey = "Contact"
    static let nameKey = "name"
    static let emailKey = "email"
    static let phoneNumberKey = "phoneNumber"
    
    //MARK: - properties
    let name: String
    let email: String
    let phoneNumber: Int
    let recordID: CKRecordID? = nil
    
    //MARK: -  member initializer
    init(name: String, email: String = "", phoneNumber: Int){
        
        self.name = name
        self.email = email
        self.phoneNumber = phoneNumber
    }
    
    //MARK: - failable initializer ** fetch **
    init?(record: CKRecord){
        guard let name = record[Contact.nameKey] as? String,
        let email = record[Contact.emailKey] as? String,
        let phoneNumber = record[Contact.phoneNumberKey] as? Int
            else { return nil }
        
        self.name = name
        self.email = email
        self.phoneNumber = phoneNumber
    }
}
//MARK: - extention on CKRecord ** save **

extension CKRecord {
    
    convenience init(contact: Contact) {
        let recordID = contact.recordID ?? CKRecordID(recordName: UUID().uuidString)
        self.init(recordType: Contact.typeKey, recordID: recordID)
        self.setValue(contact.name, forKey: Contact.nameKey)
        self.setValue(contact.email, forKey: Contact.emailKey)
        self.setValue(contact.phoneNumber, forKey: Contact.phoneNumberKey)
    }
}
