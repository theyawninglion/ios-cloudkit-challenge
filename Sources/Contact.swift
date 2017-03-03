//
//  Contact.swift
//  Contacts
//
//  Created by Taylor Phillips on 3/3/17.
//  Copyright © 2017 Dev Mountain. All rights reserved.
//

import Foundation
import CloudKit

class Contact {
    
    //MARK: - property keys
    static let nameKey = "name"
    static let phoneNumberKey = "phoneNumber"
    static let emailKey = "email"
    
    //MARK: - properties
    let name: String
    let phoneNumber: Int?
    let email: String?
    var cloudKitRecordID: CKRecordID?
    
    //MARK: - initalizers
    
    init(name: String, phoneNumber: Int? = nil, email: String? = nil) {
        self.name = name
        self.phoneNumber = phoneNumber
        self.email = email
    }
    
    init?(cloudKitRecord: CKRecord) {
        guard let name = cloudKitRecord[nameKey] as? String,
        let phoneNumber = cloudKitRecord[phoneNumberKey] as? Int,
        let email = cloudKitRecord[emailKey] as? String
            else { return nil }
        self.name = name
        self.phoneNumber = phoneNumber
        self.email = email
        self.cloudKitRecordID = cloudKitRecord.recordID
    }
    
    //MARK: - setter
    
    var cloudKitRecord: CKRecord {
        let recordID: CKRecordID = cloudKitRecordID ?? CKRecordID(recordName: UUID().uuidString)
        
        let record = CKRecord(recordType: "Contact", recordID: recordID)
        record.setValue(name, forKey: nameKey)
        record.setValue(phoneNumber, forKey: phoneNumberKey)
        record.setValue(email, forKey: emailKey)
        
        return record
    }
    
}
