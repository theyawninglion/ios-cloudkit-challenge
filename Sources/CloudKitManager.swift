//
//  CloudKitManager.swift
//  Contacts
//
//  Created by Taylor Phillips on 3/3/17.
//  Copyright © 2017 Dev Mountain. All rights reserved.
//

import Foundation
import UIKit
import CloudKit


private let CreatorUserRecordIDKey = "creatorUserRecordID"
private let LastModifiedUserRecordIDKey = "creatorUserRecordID"
private let CreationDateKey = "creationDate"
private let ModificationDateKey = "modificationDate"

class CloudKitManager {
    
    //MARK: - Properties
    
        let privateDatabase = CKContainer.default().privateCloudDatabase
    
    // check CloudKit availability
    init() {
        
        checkCloudKitAvailability()
    }
    
    
      // MARK: - Fetch Records
    func fetchAllContactsFromCloudKit(completion: @ escaping ([Contact]) -> Void) {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Contact", predicate: predicate)
        privateDatabase.perform(query, inZoneWith: nil) { (records, error) in
            guard let records = records else { return }
            let contacts = records.flatMap({Contact(cloudKitRecord: $0) })
            completion(contacts)
        }
    }

    
    // MARK: - Delete Records
    
    func deleteRecordWithID(_ recordID: CKRecordID, completion: ((_ recordID: CKRecordID?, _ error: Error?) -> Void)?) {
        privateDatabase.delete(withRecordID: recordID) { (recordID, error) in
            completion?(recordID, error)
        }
    }
    func deleteRecordsWithID(_ recordIDs: [CKRecordID], completion: ((_ records: [CKRecord]?, _ recordIDs: [CKRecordID]?, _ error: Error?) -> Void)?){
        
        let operation = CKModifyRecordsOperation(recordsToSave: nil, recordIDsToDelete: recordIDs)
        operation.savePolicy = .ifServerRecordUnchanged
        
        operation.modifyRecordsCompletionBlock = completion
        privateDatabase.add(operation)
    }
    
    
    // MARK: - Save Records
    
    func saveRecords(_ records: [CKRecord], perRecordCompletion: ((_ record: CKRecord?, _ error: Error?) -> Void)?, completion: ((_ records: [CKRecord]?, _ error: Error?) -> Void)?){
        
        modifyRecords(records, perRecordCompletion: perRecordCompletion, completion: completion)
        
    }
    
    func saveRecord(_ record: CKRecord, completion: ((_ record: CKRecord?, _ error: Error?) -> Void)?){
        
        privateDatabase.save(record) { (record, error) in
            completion?(record, error)
        }
        
    }
    
    func modifyRecords(_ records: [CKRecord], perRecordCompletion: ((_ record: CKRecord?, _ error: Error?) -> Void)?, completion: ((_ records: [CKRecord]?, _ error: Error?) -> Void)?){
        let operation = CKModifyRecordsOperation(recordsToSave: records, recordIDsToDelete: nil)
        operation.savePolicy = .changedKeys
        operation.queuePriority = .high
        operation.qualityOfService = .userInteractive
        operation.perRecordCompletionBlock = perRecordCompletion
        operation.modifyRecordsCompletionBlock = { (records, recordIDs, error) -> Void in
            (completion?(records, error))!
        }
        privateDatabase.add(operation)
        
    }
    
    
    
    // MARK: - CloudKit Availability
    
    func checkCloudKitAvailability() {
        
        CKContainer.default().accountStatus {
            (accountStatus:CKAccountStatus, error:Error?) -> Void in
            
            switch accountStatus {
            case .available:
                print("CloudKit available. Initializing full sync.")
                return
            default:
                self.handleCloudKitUnavailable(accountStatus, error: error)
            }
        }
        
    }
    
    func handleCloudKitUnavailable(_ accountStatus: CKAccountStatus, error:Error?){
        
        var errorText = "Synchronization is disabled\n"
        if let error  = error {
            print("handleCloudKitUnavailable ERROR: \(error)\nAn error occured:\(error.localizedDescription)")
            errorText += error.localizedDescription
        }
        
        switch accountStatus {
        case .restricted:
            errorText += "iCloud is not available due to restrictions"
        case .noAccount:
            errorText += "There is no CloudKit account setup.\nYou can setup iCloud in the Settings app."
        default:
            break
        }
        
    }
    
    func displayCloudKitNotAvailableError(_ errorText: String){
        DispatchQueue.main.async(execute: {
            let alertController = UIAlertController(title: "iCloud Synchronization Error", message: errorText, preferredStyle: .alert)
            let dismissAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alertController.addAction(dismissAction)
            
            if let appDelegate = UIApplication.shared.delegate,
                let appWindow = appDelegate.window!,
                let rootViewController = appWindow.rootViewController {
                rootViewController.present(alertController, animated: true, completion: nil)
            }
        })
    }
    
    
    
    // MARK: - CloudKit User Discoverability
    
    func requestDiscoverabilityPermission() {
        CKContainer.default().status(forApplicationPermission: .userDiscoverability) { (permissionStatus, error) in
            if permissionStatus == .initialState {
                CKContainer.default().requestApplicationPermission(.userDiscoverability, completionHandler: { (permissionStaus, error) in
                    self.handleCloudKitPermissionStatus(permissionStaus, error: error)
                })
            } else {
                self.handleCloudKitPermissionStatus(permissionStatus, error: error)
            }
        }
        
    }
    
    func handleCloudKitPermissionStatus(_ permissionStatus: CKApplicationPermissionStatus, error:Error?) {
        if permissionStatus == .granted {
            print("User Discoverability permission granted. User may proceed with full access.")
        } else {
            var errorText = "Synchronization is disabled\n"
            if let error = error {
                print("handleCloudKitUnavailable Error:\(error)\nAn error occured: \(error.localizedDescription)")
                errorText += error.localizedDescription
            }
            switch permissionStatus {
            case .denied:
                errorText += "You have denied User Discoverability permission. You may be unable to use certain features that requrire User Discoverability"
            case .couldNotComplete:
                errorText += "Unable to verify User Discoverability permissions. You may have a connectivity issur. Please try again."
            default:
                break
            }
            displayCloudKitPermissionsNotGrantedError(errorText)
        }
        
    }
    
    func displayCloudKitPermissionsNotGrantedError(_ errorText: String) {
        
        DispatchQueue.main.async(execute: {
            let alertController = UIAlertController(title: "CloudKit permissions Error", message: errorText, preferredStyle: .alert)
            let dismissAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            
            alertController.addAction(dismissAction)
            
            if let appDelegate = UIApplication.shared.delegate,
                let appWindow = appDelegate.window!,
                let rootViewController = appWindow.rootViewController {
                rootViewController.present(alertController, animated: true, completion: nil)
            }
        })
        
    }
}
