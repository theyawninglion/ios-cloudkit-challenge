# ContactsStretchProblem
A stretch problem for DevMountain students designed to help them implement various features of CloudKit

# Creating and saving CKRecords

- Begin by making a new project (make sure you enable CloudKit in the capabilities tab of your project file)

- Create a simple viewController with UITextFields to have the user enter a name, a phone number, and email address, and a button to save the contact.

- Create a 'Contact' model class representing a person's contact information

- Create a 'cloudKitRecord' computed property in your model class that will initialize a CKRecord, and set its values to the values of your model so that it is a representation of it in the form of a CKRecord (think 'dictionaryRepresentation' from unit 3)

- Save the record to CloudKit. Check on the CloudKit dashboard to make sure the record was successfully saved. (Note: You may have to go to the 'default zone' in the dashboard and click the 'Add Record ID Query Index')

# Black Diamonds

- Write your own function from scratch to save the CKRecord (don't use the CloudKitManager functions)

- Implement a UIImagePickerController to a contact photo. Update your model and cloudKitRecord to reflect the changes. 
