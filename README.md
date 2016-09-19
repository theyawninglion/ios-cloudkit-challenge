# ContactsStretchProblem

A stretch problem for DevMountain students designed to help them implement various features of CloudKit

# Part 1: Creating and saving CKRecords

- Begin by making a new project (make sure you enable CloudKit in the capabilities tab of your project file)

- Create a simple ViewController with UITextFields to have the user enter a name, a phone number, and email address, and a button to save the contact.

- Create a 'Contact' model class representing a person's contact information

- Create a 'cloudKitRecord' computed property in your model class that will initialize a CKRecord, and set its values to the values of your model so that it is a representation of it in the form of a CKRecord (think 'dictionaryRepresentation' from Unit 3)

- Save the record to CloudKit. Check on the CloudKit Dashboard to make sure the record was successfully saved. (Note: You may have to go to the 'default zone' in the Dashboard and click the 'Add Record ID Query Index')

# Black Diamonds

- Save the cloudKitRecord without using or looking at the CloudKitManager functions. (Look at the documentation)

- Implement a UIImagePickerController to select a contact photo. Update your model and cloudKitRecord to reflect the changes. 

# Part 2: Fetching Records

- Create a TableViewController to display the contacts you will fetch from CloudKit. (Note: You may segue to this TableViewController however you wish)

- In your model controller, create a function that will fetch all stored contacts on CloudKit. (If you choose to create it without the CloudKitManager, there is more than one way to fetch records from CloudKit.)

- In the same function, initialize new contact objects from the records you just fetched, and assign them to a variable that is accessible to the TableViewController you just made. 

- Populate the TableViewController.

# Black Diamonds

- If you have time, experiment with NSPredicates to see how you can use them to fetch only specific records. 

# Part 3: Subscriptions

- In your model controller, create a function that will create, set up, and save a subscription. (Note: In iOS 10, subcriptions are now CKQuerySubscription. Pre-iOS 10 subscriptions are CKSubscriptions)

- In the App Delegate, register and request authorization for User Notification Settings. (When writing for iOS 10, use the new UNUserNotificationCenter. Otherwise, create UIUserNotifificationSettings)

- Turn on the 'Remote Notifications' capability in the Background Modes section of the capabilities tab.

- Call your subscription function.

- Run the project on the simulator and a physical device to make sure the subscriptions work (Note: The simulator is bad at receiving notifications if at all. Create the contact on the simulator, then look on your physical device to see if it either hits the App Delegate didReceiveRemoteNotification function, or gets a banner notification.)

# Black Diamonds
