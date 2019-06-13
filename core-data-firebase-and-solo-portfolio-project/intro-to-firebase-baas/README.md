# Firebase Intro

## [Demo App](https://github.com/joinpursuit/Pursuit-Core-iOS-RaceReviews)   

## Objectives

1. Understand what Firebase is and what it is used for
2. Integrate Firebase Auth into a project
3. Integrate Firebase Database into a project

# 1. What is Firebase and why would we want to use it?

Firebase is a platform that manages a backend for mobile applications.  There are three main features that Firebase offers that we will take advantage of.

1. Authentication
2. Cloud Firestore database
3. Storage (Images, etc)

Without a backend, there is a limit to what kind of apps we are able to build.  We have been able to build applications that request and process data, and even applications that post some limited amount of information.  Companies like Facebook or Spotify provide APIs for logging into user accounts and editing information using OAuth.  But these services only let you interact with specific products.  If we want to build our own service, we need to have our own backend.

Firebase provides this backend to mobile developers.  There is a [free tier](https://firebase.google.com/pricing/), which we will be using which limits the storage and number of simulatenous users that can be on your app.  Paid tiers raise these limits.

# 2. Competitors to Firebase

Firebase is one of the most popular backend as a service providers, but there are other competitors.  CloudKit is Apple's service that requires an iCloud account which makes it only useful for iOS users.  Amazon Web Services provides an alternative to Firebase that provides the same functionality, but can be trickier to learn. Realm is also a very strong competitor to Firebase.

1. [CloudKit](https://developer.apple.com/icloud/)    
2. [Amazon Web Services](https://aws.amazon.com/)    
3. [Realm](https://realm.io/)   


# 3. Getting Started

The point of Firebase is to create an app that many users will be able to access.  But how do we use it?  We are going to create a very small app today that will run through Authorization and reading and writing data for a simple model.

To begin, create a new XCode project named **GroceryList**.

Then, go to [https://firebase.google.com/](https://firebase.google.com/) and login.  You can login with any gmail account.  Once you are logged in, click on the button at the top labeled "Go To Console".  Click on the plus icon to create a new project.

You will be brought to a Firebase dashboard. Here will be all the options you now have for your Firebase Project, some are Authentication, Datatabase and Storage. Navigate to the top left of the dashboard. Click on Settings -> Project Settings.  Click on the iOS option below **Your apps** and it will have you complete the following steps:

1. Register your Bundle Identifier (Copy Bundle Id from Xcode).
2. Download the Google plist and drag it in directly below your Info.plist. Make sure "Copy Items if needed" is selected when you drag the .plist file to Xcode. The GoogleService-Info.plist file contains settings that Firebase uses to set up your app.
3. Add the Firebase SDK. We will be using Cocoapods. Navigate to the root of your Xcode project in Terminal and run ```pod init```.  Open the newly created podfile ```open Podfile``` and add ```pod 'Firebase/Core'``` below ```# Pods for``` .  Run ```pod install```.

Let's also add the following pods to our project, so go ahead and include the Database and Auth pod in your Podfile and run ```pod install``` again:

```
pod 'Firebase/Database'
pod 'Firebase/Auth'
pod 'Firebase/Firestore'
```

Running ```ls``` will now reveal additional files/folders in your project.
- ProjectName.xcworkspace
- Podfile			
- Podfile.lock		
- Pods

If your Xcode project is opened, close it then open the ```.xcworkspace``` file which now includes Firebase.
4. Navigate to your App Delegate, ```import Firebase```, then under didFinishLaunchingWithOptions, add the line:

```swift
FirebaseApp.configure()
```

You are now set up to use Firebase!  

5. Run your app to verify installation

![firebase added](https://github.com/joinpursuit/Pursuit-Core-iOS/blob/master/units/unit05/lesson-08-intro-to-firebase-baas/Images/firebase-added.png)   

# 4. Configuring Auth

Our app is now setup to talk to Firebase.  Our first step will be to enable users to create an account and sign in.

### Website configuration

Go to your console online and select "Authentication" in the side bar menu.  Then select **Set up sign-in Method**.  You can choose from any of the given options.  For this app, select "Email/Password".  You can now see a list of all users, which is empty.  Our first task will be to create a sign-in screen where someone is able to create an account or log in.

### Build your UI

Return to your xcode workspace project. Let's create a  .xib Login View. We will need a text field for the email address, a secure text field for the password, a button for signing in, and a button for creating an account.

Create or refactor/rename the default ViewController to "LoginViewController".

The LoginViewController will host the LoginView.xib and outlets will be connected to a created LoginView.swift UIView subclass.

### Add auth logic

Create a **UserSession** class to hold all Firebase authentication methods e.g createUser(), signInExistingUser(), signOut().

In your UserSession class, import **FirebaseAuth**

For Auth, we will have two instance methods

#### 1) Create account

```swift
public func createUser(email: String, password: String) {
  Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
    if let error = error {
      self.userCreationDelegate?.didRecieveErrorCreatingUser(self, error: error)
    } else if let authResult = authResult {
      self.userCreationDelegate?.didCreateFirebaseUser(self, user: authResult.user)
    }
  }
}
```

#### 2) Login to an account

```swift
public func signInExistingUser(email: String, password: String) {
  Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
    if let error = error {
      self.userSignInDelegate?.didRecieveErrorSignInUser(self, error: error)
    } else if let authResult = authResult {
      self.userSignInDelegate?.didSignInExistingFirebaseUser(self, user: authResult.user)
    }
  }
}
```

... more methods as needed.

It's that simple!  Firebase does all the heavy lifting for you.  Let's configure our View controller to call these methods appropriately.


Here we are using a custom delegate (UserSessionCreationDelegate) to listen for Firebase responses
```swift
extension LoginController: UserSessionCreationDelegate {
  func didRecieveErrorCreatingUser(_ userSession: UserSession, error: Error) {
    showAlert(title: "Creating User Error",
              message: error.localizedDescription)
  }

  func didCreateFirebaseUser(_ userSession: UserSession, user: User) {
    presentGroceryTabController(user: user, title: "Successfully Created User", message: "created new user using \(user.email ?? "no email") email")    
    DatabaseManager.saveUser()
  }
}
```

If the user successfully creates an account segue to the Tab bar Controller

```swift
private func presentGroceryTabController(user: User, title: String, message: String) {
  let alertController = UIAlertController(title: title,
                                          message: message, preferredStyle: .alert)
  let okAction = UIAlertAction(title: "Ok", style: .default) { alert in
    let groceryTabStoryboard = UIStoryboard(name: "RaceReviewsTab", bundle: nil)
    let raceReviewsTabController = groceryTabStoryboard.instantiateViewController(withIdentifier: "RaceReviewsTabController") as! RaceReviewsTabController
    raceReviewsTabController.modalTransitionStyle = .crossDissolve
    raceReviewsTabController.modalPresentationStyle = .overCurrentContext
    self.present(raceReviewsTabController, animated: true)
  }
  alertController.addAction(okAction)
  present(alertController, animated: true, completion: nil)
}
```

# 5. Using the database to read and write data

#### Getting Started

Now that we can create users, what can they do?  We are going to create a simple to-do list that will demonstrate the features of the Cloud Firestore.

Ariticles on differences between Firebase Realtime Database and Cloud Firestore
1. [Firebase - Choosing a database](https://firebase.google.com/docs/firestore/rtdb-vs-firestore)  
1. [Stackoverflow](https://stackoverflow.com/questions/46549766/whats-the-difference-between-cloud-firestore-and-the-firebase-realtime-database)  

**Realtime Database** is Firebase's original database. It's an efficient, low-latency solution for mobile apps that require synced states across clients in realtime.

**Cloud Firestore** is Firebase's new flagship database for mobile app development. It improves on the successes of the Realtime Database with a new, more intuitive data model. Cloud Firestore also features richer, faster queries and scales better than the Realtime Database.

**Create a Cloud Firestore project**  
1. In the Database section, click the Get Started button for Cloud Firestore.
1. Select a starting mode for your Cloud Firestore Security Rules.

We will use the following security rule below, this rule ensure that only authenticated users can read and write to our database:

```javascript
// Allow read/write access on all documents to any user signed in to the application
service cloud.firestore {
  match /databases/{database}/documents {
    match /{document=**} {
      allow read, write: if request.auth.uid != null;
    }
  }
}
```

**Initialize Cloud Firestore**   

```swift
import Firebase

FirebaseApp.configure()

let db = Firestore.firestore()
```

**Add data**  

```swift
// Using Firebase Cloudstore - Writing a race review document to the database
static func postRaceReviewToDatabase(race: Race) {
  var ref: DocumentReference? = nil
  ref = firestoreDB.collection("raceReviews").addDocument(data: [
    "reviewerId"  : race.reviewerId,
    "name"        : race.name,
    "type"        : "\(race.type)",
    "review"      : race.review,
    "lat"         : race.lat,
    "lon"         : race.lon,
    "createdDate" : Date.getISOTimestamp()
  ]) { err in
    if let err = err {
      print("Error adding document: \(err)")
    } else {
      print("Document added with ID: \(ref!.documentID)")
    }
  }
}

// Using Firebase Cloudstore - Writing a user document to the database
static func saveCreatedUserToDatabase() {
  guard let user = Auth.auth().currentUser else {
    print("no logged user")
    return
  }
  var ref: DocumentReference? = nil
  ref = firestoreDB.collection("users").addDocument(data: [
    "userId" : "\(user.uid)",
    "username": user.email ?? "no email",
    "createdDate": Date.getISOTimestamp()
  ])
    { (error) in
    if let error = error {
      print("error adding user to database: \(error)")
    } else {
      print("user added to database with id: \(ref!.documentID)")
    }
  }
}
```

**Read data**   

To quickly verify that you've added data to Cloud Firestore, use the data viewer in the [Firebase console](https://console.firebase.google.com/project/_/database/firestore/data?authuser=1).

You can also use the "get" method to retrieve the entire collection.

```swift
private func fetchRaceReviews() {
  DatabaseManager.firestoreDB.collection("raceReviews")
    .addSnapshotListener { querySnapshot, error in
      if let error = error {
        print("Error retreiving collection: \(error)")
      } else if let querySnapshot = querySnapshot {

        var races = [Race]()
        for document in querySnapshot.documents {
          let race = Race(dict: document.data())
          print(race.name)
          races.append(race)
        }
        self.raceReviews = races
      }
  }
}
```


# 6. Cloud Firestore Data model

Cloud Firestore is a NoSQL, document-oriented database. Unlike a SQL database, there are no tables or rows. Instead, you store data in documents, which are organized into collections.

Each document contains a set of key-value pairs. Cloud Firestore is optimized for storing large collections of small documents.

All documents must be stored in collections. Documents can contain subcollections and nested objects, both of which can include primitive fields like strings or complex objects like lists.

Collections and documents are created implicitly in Cloud Firestore. Simply assign data to a document within a collection. If either the collection or document does not exist, Cloud Firestore creates it.

**Documents**  
In Cloud Firestore, the unit of storage is the document. A document is a lightweight record that contains fields, which map to values. Each document is identified by a name.

A document might look like this

```json
cohort: 6.1
currentYear: 2020
programmingLanguage: "Swift"
platform: "iOS"
```

**Collections**  
Documents live in collections, which are simply containers for documents. For example, you could have a users collection to contain your various users, each represented by a document:

<pre>
users:
	first: "Tom"
	last" "Jones"

	first: "Heather"
	last: "Jackson"
</pre>

**Data types supported by Cloud Firestore**  
- Array (note: cannot contain another array value)  
- Boolean e.g true or false
- Bytes
- Date and time
- Floating point number
- Geographical point
- Integer
- Dictionaries e.g { first: "Martha" }
- Null
- Reference e.g projects/[PROJECT_ID]/databases/[DATABASE_ID]/documents/[DOCUMENT_PATH]
- Text String


## Readings
[Firebase Docs](https://firebase.google.com/docs/ios/setup?authuser=0)  
[Authentication](https://firebase.google.com/docs/auth/?authuser=1)     
[Cloud Firestore](https://firebase.google.com/docs/firestore/?authuser=1)   
[Cloud Storage](https://firebase.google.com/docs/storage/?authuser=1)
