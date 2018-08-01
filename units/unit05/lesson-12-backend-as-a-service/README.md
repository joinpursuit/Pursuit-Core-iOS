# Firebase Intro

### [Project Link](https://github.com/C4Q/AC-iOS-FirebaseIntroProject)

## Readings

1. [Firebase Docs](https://firebase.google.com/docs/ios/setup?authuser=0)
2. [Ray Wenderlich](https://www.raywenderlich.com/139322/firebase-tutorial-getting-started-2)
3. [appcoda](https://www.appcoda.com/firebase/)
4. [codelabs.developers.google.com](https://codelabs.developers.google.com/codelabs/firebase-ios-swift/#0)

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

Firebase provides this backend to mobile developers.  There is a free tier, which we will be using which limits the storage and number of simulatenous users that can be on your app.  Paid tiers raise these limits.

# 2. Competitors to Firebase

Firebase is one of the most popular backend as a service providers, but there are other competitors.  CloudKit is Apple's service that requires an iCloud account.  Amazon Web Services provides an alternative to Firebase that provides the same functionality, but can be trickier to learn.  Parse was a Facebook created platform that was very user-friendly and had many free features.  Parse, run by Facebook was probably the most popular and well-documented platform, but was [shut down somewhat unexpectedly](https://techcrunch.com/2017/01/30/facebooks-parse-developer-platform-is-shutting-down-today/) in early 2017.

1. [CloudKit](https://developer.apple.com/icloud/)
2. [Amazon Web Services](https://aws.amazon.com/)
3. [Parse Server](https://github.com/ParsePlatform/parse-server)


# 3. Getting Started

The point of Firebase is to create an app that many users will be able to access.  But how do we use it?  We are going to create a very small app today that will run through Authorization and reading and writing data for a simple model.

To begin, create a new XCode project named "To-do list".

Then, go to [https://firebase.google.com/](https://firebase.google.com/) and login.  You can login with any gmail account.  Once you are logged in, click on the button at the top labeled "Go To Console".  Click on the plus icon to create a new project.

You will be brought to a splash screen that has some guides for getting started.  Click on the iOS option and it will have you complete the four following steps:

1. Register your Bundle Identifier (in the General section under Identity when you select the topmost file).
2. Download the Google plist and drag it in directly below your Info.plist.  This contains settings that Firebase uses to set up your app.
3. Run pod init in your repo.  Open the podfile and add 'Firebase/Core' to your pods.  Run pod install, then open the xcworkspace file.
4. Navigate to your App Delegate, import Firebase, then under didFinishLaunching, add the line: 

```swift
FirebaseApp.configure()
```

You are now set up to use Firebase!  We'll want a few extra Pods to make use of what Firebase has to offer, so go ahead and install:

```
pod 'Firebase/Database'
pod 'Firebase/Auth'
```

# 4. Configuring Auth

Our app is now setup to talk to Firebase.  Our first step will be to enable users to create an account and sign in.

### Website configuration

Go to your console online and select "Authentication" in the side bar menu.  Then select "Set Up Sign-In Method".  You can chose from any of these options.  For this app, select "Email/Password".  You can now see a list of all users, which is empty.  Our first task will be to create a sign-in screen where someone is able to create an account or log in.

### Build your UI

Return to your xcode workspace and go to your Storyboard.  Create a text field for the email address, a secure text field for the password, a button for signing in, and a button for creating an account.

Go to the ViewController.swift file and rename it to "LoginViewController".

Create outlets in your View Controller to both your text fields, and create IBActions for each of your buttons.

### Add auth logic

Firebase is going to be a service responsible for many different functions, so we are going to want to build a singleton for it to keep its code out of the rest of our project.  This is also helpful if we ever need to change backend providers, there is only one class that directly talks to Firebase that we could refactor.

In your FirebaseAPIClient, import FirebaseAuth

For Auth, we will have two instance methods

#### 1) Create account

```swift
func createNewAccount(with email: String, and password: String, completion: @escaping (User?, Error?) -> Void) {
    Auth.auth().createUser(withEmail: email, password: password, completion: completion)
}

```

#### 2) Login to an account

```swift
func loginToAccount(with email: String, and password: String, completion: @escaping (User?, Error?) -> Void) {
    Auth.auth().signIn(withEmail: email, password: password, completion: completion)
}
```

It's that simple!  Firebase does all the heavy lifting for you.  Let's configure our View controller to call these methods appropriately.


```swift
@IBAction func signInButtonPressed(_ sender: UIButton) {
    //TO-DO: Validate email and password
    let email = emailTextField.text!
    let pass = passwordTextField.text!
    FirebaseAPIClient.manager.loginToAccount(with: email, and: pass){(user, error) in
        if let error = error {
            //TO DO: Handle errors
            print(error)
            return
        }
        if let user = user {
            //TO DO: Navigate to next screen
            print("\(user) has logged in")
        }
    }
}
    
@IBAction func createAccountButtonPressed(_ sender: UIButton) {
    let email = emailTextField.text!
    let pass = passwordTextField.text!
    FirebaseAPIClient.manager.createNewAccount(with: email, and: pass){(user, error) in
        guard error == nil else { print(error); return }
        if let user = user {
            print("Created new user: \(user)")
        }
    }
}
```

Try creating several different user accounts, then pick one to log in as.  Go to your Firebase console to see users being added in real time.

# 5. Using the database to read and write data

#### Getting Started

Now that we can create users, what can they do?  We are going to create a simple to-do list that will demonstrate the features of the Firebase database.

Reading and writing to Firebase looks a little different compared to requests we've done before.  Let's take a look at the Database tab in Firebase to see what we are working with.  Select "Realtime database" in the tab at the left, then select "Get Started".

You'll see a canvas with a line on it that has the project name.  Data in Firebase is essentially just JSON.  It is comprised of nodes, each of which can have children.  You can create nodes direclty inside this canvas here, or even export JSON.  Let's give ourselves some sample data to use.

#### Creating Sample Data

Click on the plus button, and make a new node called "tasks"

Click on the plus button of "tasks" and make a new node with a key of "laundry" and value of "finished".  Make two or three additional tasks in the same manner.

Now that we have some data stored online, we'll need to find a way to access it inside our app.


#### Building the UI

Let's create a tableviewcontroller to display all the tasks that we have.

Drag a TableViewController into your Storyboard scene.  Create a modal segue from the LoginViewController to your new TableViewController.  Change the cell type to "subtitle" and give your cell a reuse identifier of "Task Cell".

In your LoginViewController, have your completion handlers perform the segue to go to the TableViewController when the user is successfully logged in.  

(As a side note, these functions are a little repetitive.  We should probably refactor this later to be a single function.)

```swift
    @IBAction func signInButtonPressed(_ sender: UIButton) {
        //TO-DO: Validate email and password
        let email = emailTextField.text!
        let pass = passwordTextField.text!
        FirebaseAPIClient.manager.loginToAccount(with: email, and: pass){(user, error) in
            if let error = error {
                //TO DO: Handle errors
                print(error)
                return
            }
            if let user = user {
                print("\(user) has logged in")
                self.performSegue(withIdentifier: "Login Segue", sender: self)

            }
        }
    }
    
    @IBAction func createAccountButtonPressed(_ sender: UIButton) {
        let email = emailTextField.text!
        let pass = passwordTextField.text!
        FirebaseAPIClient.manager.createNewAccount(with: email, and: pass){(user, error) in
            guard error == nil else { print(error!); return }
            if let user = user {
                print("Created new user: \(user)")
                self.performSegue(withIdentifier: "Login Segue", sender: self)
            }
        }
    }
```

#### Configuring the TableView

Create a new file TasksTableViewController.swift that we will use to manager our TableViewController.  Make sure to change its name in your Storyboard as well.

Build a quick Task struct to model our tasks:

```swift
struct Task {
    let name: String
    let status: String
}
```

Then, build your Tableview controller to display an array of Tasks:

```swift
class TasksTableViewController: UITableViewController {

    var tasks = [Task]() {
    	didSet {
    		tableView.reloadData()
    	}
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }

    func loadData() {
        //??
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Task Cell", for: indexPath)
        let task = tasks[indexPath.row]
        cell.textLabel?.text = task.name
        cell.detailTextLabel?.text = task.status
        return cell
    }
}
```

All that is left now is to implement loadData()

#### Reading data from Firebase

Because this part will touch Firebase, we'll want to go to our FirebaseAPIClient.  Add a new instance method to load all Tasks from online.

```swift
func loadTasks(completionHandler: @escaping ([Task]?, Error?) -> Void) {
    
}
```

Because Database is different than Auth, we'll need to import Firebase/Database.  Then, we get a reference to the child node that we are interested in.

```swift
let ref = Database.database().reference().child("tasks")
```

We then want to observe what's there and convert all of the children into Task objects.


```swift
    func loadTasks(completionHandler: @escaping ([Task]?, Error?) -> Void) {
        let ref = Database.database().reference().child("tasks")
        ref.observe(.value){(snapShot) in
            guard let snapShots = snapShot.children.allObjects as? [DataSnapshot] else { return }
            var allTasks = [Task]()
            for snap in snapShots {
                let taskName = snap.key
                if let taskStatus = snap.value as? String {
                    let task = Task(name: taskName, status: taskStatus)
                    allTasks.append(task)
                }
            }
            completionHandler(allTasks, nil)
        }
    }
```

#### Realtime means realtime

Return to the Firebase console and go to the Database.  Try inserting new tasks, changing tasks, and deleting tasks.  Your app will immediately update in realtime to reflect those changes.  Super easy and super powerful.

#### A more interesting Task model

But this data is just a String!  Usually, we would want to store a custom object inside firebase.  Also, it's not typical for the keys to have information about our model.  Usually, the keys of the children are configured to be unique identifies.  Otherwise, we wouldn't be able to have tasks with the same name.

Let's try to store the modified task object below:

```swift
stuct Task: Codable {
	var name: String
	var status: String
	var estimatedTime: Int
	var rating: Double
}
```

Clearly we can't just use the key/value pair to store all of this information.  Fortunately, the value of any node doesn't have to be a String, it can be its own JSON!  There are many ways to convert our model to something Firebase will be happy with, including converting it to a NSDictionary.  The easiest approach is to convert our Task to a JSON Any using JSONEncoder and JSONSerializtion.

```swift
stuct Task: Codable {
	var name: String
	var status: String
	var estimatedTime: Int
	var rating: Double
	func toJSON() -> Any {
		let jsonData = try JSONEncoder().encode(self)
    	return try! JSONSerialization.jsonObject(with: jsonData, options: [])
	}
}
```

#### Writing Data

We will cover writing data in much more detail tomorrow, but we'll get a start on it right now.  Writing data is a pretty simple process.  Get a reference to the place you want to write to, then set its value to any type that Firebase will be happy with.

If we are adding something to a list, we want to ensure that the keys are unique.  Firebase provides a method that promises to give you a unique key to use.  The method below adds three of our improved tasks to Firebase.

```swift
func addTestTasks() {
    let ref = Database.database().reference().child("tasks")
    let taskOne = Task(name: "laundry", status: "completed", estimatedTime: 60, rating: 3.4)
    let taskTwo = Task(name: "dishes", status: "incomplete", estimatedTime: 30, rating: 1.4)
    let taskThree = Task(name: "homework", status: "in progress", estimatedTime: 9001, rating: 5.0)
    ref.childByAutoId().setValue(taskOne.toJSON())
    ref.childByAutoId().setValue(taskTwo.toJSON())
    ref.childByAutoId().setValue(taskThree.toJSON())
}
```

Call this method in your app delegate (or wherever) to get these sample Tasks pushed to Firebase. 

We can confirm in the Firebase Console that our data has been added. Then delete your call to addTestTasks() so you don't have lots of duplicate entries.

**Important Note!**  If your JSON has any Arrays in it, Firebase will either silently ignore them, or transform them into Dictionaries.  If you want to store collections of things, you'll need to use the JSON structure or store Dictionaries.


#### Reading our custom objects

Now that our data is living safely online, how can we get it?  We'll need to rewrite our loadTasks inside our FirebaseAPIClient:


```swift
func loadTasks(completionHandler: @escaping ([Task]?, Error?) -> Void) {
    let ref = Database.database().reference().child("tasks")
    ref.observe(.value){(snapShot) in
        guard let snapShots = snapShot.children.allObjects as? [DataSnapshot] else { return }
        var allTasks = [Task]()
        for snap in snapShots {
            guard let rawJSON = snap.value else { continue }
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: rawJSON, options: [])
                let task = try JSONDecoder().decode(Task.self, from: jsonData)
                allTasks.append(task)
            }
            catch {
                print(error)
            }
        }
        completionHandler(allTasks, nil)
    }
}
```


We'll also change our cell for row at to see if we are getting the new data.

```swift
cell.detailTextLabel?.text = "status: \(task.status), time: \(task.estimatedTime), rating: \(task.rating)"
```

Build and run your app, and you should see the new and improved Tasks populating your TableView.