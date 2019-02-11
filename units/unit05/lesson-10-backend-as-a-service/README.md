# Firebase Intro

## Readings

[Firebase Docs](https://firebase.google.com/docs/ios/setup?authuser=0)


## Objectives

1. Understand what Firebase is and what it is used for
2. Integrate Firebase Auth into a project
3. Integrate Firebase Database into a project

# 1. What is Firebase and why would we want to use it?

Firebase is a platform that manages a backend for mobile applications.  There are three main features that Firebase offers that we will take advantage of.

1. Realtime database
2. Authentication
3. Image Hosting

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

![firebase added](https://github.com/alexpaul/LessonDrafts/blob/master/Firebase/Images/firebase-added.png)   

# 4. Configuring Auth

Our app is now setup to talk to Firebase.  Our first step will be to enable users to create an account and sign in.

### Website configuration

Go to your console online and select "Authentication" in the side bar menu.  Then select **Set up sign-in Method**.  You can choose from any of the given options.  For this app, select "Email/Password".  You can now see a list of all users, which is empty.  Our first task will be to create a sign-in screen where someone is able to create an account or log in.

### Build your UI

Return to your xcode workspace project. Let's create a  .xib Login View. We will need a text field for the email address, a secure text field for the password, a button for signing in, and a button for creating an account.

Create or refactor/rename the default ViewController to "LoginViewController".

The LoginViewController will host the LoginView.xib and outlets will be connected to a created LoginView.swift UIView subclass. 

### Add auth logic

Firebase is going to be a service responsible for many different functions, so we are going to want to build a singleton for it to keep its code out of the rest of our project.  This is also helpful if we ever need to change backend providers, there is only one class that directly talks to Firebase that we could refactor.

In your FirebaseAPIClient, import FirebaseAuth

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
