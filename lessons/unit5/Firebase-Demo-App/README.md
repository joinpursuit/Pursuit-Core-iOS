## Firebase 
Everything you need to build and grow your app, all in one place.

## Objectives 
* Review about the Firebase stack 
* Managing users 
* Structuring data 
* Read, Write to the Database 
* Read, Write to Storage 

## Firebase Authentication 
Most apps need to know the identity of a user. Knowing a user's identity allows an app to securely save user data in the cloud and provide the same personalized experience across all of the user's devices.
Firebase Authentication provides backend services, easy-to-use SDKs, and ready-made UI libraries to authenticate users to your app. It supports authentication using passwords, phone numbers, popular federated identity providers like Google, Facebook and Twitter, and more.

```swift 
if Auth.auth().currentUser != nil {
  // User is signed in.
  // ...
} else {
  // No user is signed in.
  // ...
}
```

```swift 
Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
  // ...
}
```

Firebase Authentication integrates tightly with other Firebase services, and it leverages industry standards like OAuth 2.0 and OpenID Connect, so it can be easily integrated with your custom backend.

## Firebase Realtime Database 
Store and sync data with our NoSQL cloud database. Data is synced across all clients in realtime, and remains available when your app goes offline.

The Firebase Realtime Database is a cloud-hosted database. Data is stored as JSON and synchronized in realtime to every connected client. When you build cross-platform apps with our iOS, Android, and JavaScript SDKs, all of your clients share one Realtime Database instance and automatically receive updates with the newest data.


## Database Structure 
Avoiding Nesting Data
Because the Firebase Realtime Database allows nesting data up to 32 levels deep, you might be tempted to think that this should be the default structure. However, when you fetch data at a location in your database, you also retrieve all of its child nodes. In addition, when you grant someone read or write access at a node in your database, you also grant them access to all data under that node. Therefore, in practice, it's best to keep your data structure as flat as possible.

Flatten data structures
If the data is instead split into separate paths, also called denormalization, it can be efficiently downloaded in separate calls, as it is needed.

Install Firebase Database  
```
pod 'Firebase/Database'
```

Getting a Database reference 
```swift 
var ref: DatabaseReference!
ref = Database.database().reference()
```

Disk Persistence
Firebase apps automatically handle temporary network interruptions. Cached data is available while offline and Firebase resends any writes when network connectivity is restored.

When you enable disk persistence, your app writes the data locally to the device so your app can maintain state while offline, even if the user or operating system restarts the app.

You can enable disk persistence with just one line of code.

```swift
Database.database().isPersistenceEnabled = true
```

## Firebase Cloud Storage
Cloud Storage is built for app developers who need to store and serve user-generated content, such as photos or videos.

Cloud Storage for Firebase is a powerful, simple, and cost-effective object storage service built for Google scale. The Firebase SDKs for Cloud Storage add Google security to file uploads and downloads for your Firebase apps, regardless of network quality. You can use our SDKs to store images, audio, video, or other user-generated content. On the server, you can use Google Cloud Storage, to access the same files.

Add Storage to your app
```swift
pod 'Firebase/Core'
pod 'Firebase/Storage'
```

Get a reference to the Storage service 
```swift
// Get a reference to the storage service using the default Firebase App
let storage = Storage.storage()

// Create a storage reference from our storage service
let storageRef = storage.reference()
```

## In Class Demo App 
We will be building a Job marketplace social app using Firebase as our backend. A user will be able to post a job to the marketplace or search from the marketplace for a job.   

Entities, Tables or References Database Schema: 
* Users
* Jobs 
* Images 
* Category

**Getting setup with Firebase:** 

Go to your [Firebase console](https://console.firebase.google.com/?authuser=1) to get started

Some tasks needed to include Firebase in your iOS app include: 

Create Podfile  
```pod init```

Include the following Pod   
```pod 'Firebase/Core'``` 

Install Pods  
```pod install```

Include the following in your AppDelegate:  
```swift 
import Firebase
```

```swift 
// Use Firebase library to configure APIs
FirebaseApp.configure()
```

Include the downloaded Google Plist file into your Xcode project. If you need to redownload that Plist file you can visit your Project Settings in the Firebase console.  

When completed and pods are installed open ```YourAppName.xcworkspace```   

**In Class Demo App - Database Structure**   

|Users|Jobs|Images|Category|
|:----|:----|:----|:----|
|userId|jobId|imageId|categoryId|
|authUserId|authUserId|authUserId|title|
|username|title|imageURL||
|jobs{}|description|jobId||
|category{}|userId|||
||creator|||
||contractor|||
||category{}|||
||imageURL|||
||isScheduled|||
||isComplete|||

[Security and Rules](https://firebase.google.com/docs/database/security/?authuser=1)  
```json
{
  "rules": {
    ".read": "auth != null",
    ".write": "auth != null", 
    "jobs" : {
    	"$jobId" : {
        ".validate" : "newData.hasChildren(['imageURL'])"
      }
    }
  }
}
```


## Resources 
|Resource|Summary|
|:----------|:------------|
|[Firebase Console](https://console.firebase.google.com/?authuser=1)|Firebase Console|
|[Authentication](https://firebase.google.com/docs/auth/)|Authentication|
|[Database](https://firebase.google.com/docs/database/)|Firebase Database|
|[Storage](https://firebase.google.com/docs/storage/)|Firebase Cloud Storage|
|[Available Pods](https://firebase.google.com/docs/ios/setup?authuser=1)|These pods are available for the different Firebase features.|
|[Security and Rules](https://firebase.google.com/docs/database/security/?authuser=1)|More on Security and Rules|  
