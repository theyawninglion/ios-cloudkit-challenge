# Instructions for Unit 4 Challenge

## Covered Concepts

This challenge is intended to assess your ability to build applications that sync data between devices using CloudKit. It covers the following concepts taught in Unit 4:

- CloudKit setup (provisioning, CloudKit containers, etc.)
- Conversion from application-specific model objects to/from CKRecord
- Use of CKQuery to fetch data from CloudKit
- Proper separation of concerns. CloudKit restricted to the model/model controller layer.
- Ability to add records to, delete records from, and update records on CloudKit.

## Requirements

The included screen recording demonstrates the application you are to create for this challenge. Note the following requirements:

1. Initial screen shows a list of contact names.
2. Tapping the plus button in the top right corner brings up a screen with text fields to enter a name, phone number, and email address for a new contact. The user should required to enter a name. Phone number and email address fields may be left blank.
3. Tapping the Save button saves the new contact and returns to the list of contacts.
4. Tapping on a contact name in the list shows a detail view **which allows editing** the existing contact.
5. If the app is killed and restarted, previously saved contacts must continue to be shown.
6. If the app is launched on another device signed into the same iCloud account, it must also show the users' contacts.

# Black Diamonds:
- Add support for deleting contacts by swiping on them in the list view.
- Use CKSubscription to make it so that data is automatically updated on one device when it is edited on another.
- Add local persistence so that users without a network connection can see their existing contacts.
- Add a search bar to the contacts list view to allow the user to search for specific contacts.

**Note**: You **may not** use the CloudKit manager class from Timeline. Please write a small, focused CloudKitManager class for this challenge.

You will have 3 hours and 30 minutes to complete this challenge.
