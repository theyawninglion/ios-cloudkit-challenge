//
//  CloudKitManger.swift
//  Contacts
//
//  Created by Taylor Phillips on 3/10/17.
//  Copyright © 2017 Dev Mountain. All rights reserved.
//

import Foundation
import CloudKit
class CloudKitMangager {
    
    let privateDataBase = CKContainer.default().privateCloudDatabase
    
    //MARK: - CloudKit functions
    
    func saveRecord(record: CKRecord, completion: @escaping () -> Void) {
        
        privateDataBase.save(record) { (_, error) in
            if let error = error {
                print("Error saving to CloudKit: \(error.localizedDescription)")
                completion()
                return
            }
            print("Successful save to CloudKit")
            completion()
        }
    }
    
    func fetchRecords(type: String, completion: @escaping ([CKRecord]) -> Void ) {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: type, predicate: predicate)
        privateDataBase.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print("Error fetching records from CloudKit \(error.localizedDescription)")
                completion([])
                return
            }
            print("Succesful records fetch from CloudKit")
            guard let records = records else { completion([]); return }
            completion(records)
            
        }
        
    }
    func modifyRecord(record: CKRecord, completion: () -> Void){
        // FIXME: - modifyRecord
//        privateDataBase.add(<#T##operation: CKDatabaseOperation##CKDatabaseOperation#>)
    }
    
    func deleteRecord(recordID: CKRecordID, completion: ((_ recordID: CKRecordID?, _ error: Error?) -> Void)?) {
        privateDataBase.delete(withRecordID: recordID) { (recordID, error) in
            completion?(recordID, error)
        }
    }
}
